package services

import (
	"chat/common/log"
	"context"
	etcdclient "go.etcd.io/etcd/client"
	"google.golang.org/grpc"
	cli "gopkg.in/urfave/cli.v2"
	"os"
	"path/filepath"
	"strings"
	"sync"
	"sync/atomic"
	"time"
)

// a single connection
type client struct {
	key  string
	conn *grpc.ClientConn
}

// a kind of service
type service struct {
	clients []client
	idx     uint32 // for round-robin purpose
}

// all services
type service_pool struct {
	root           string
	names          map[string]bool
	services       map[string]*service
	names_provided bool
	client         etcdclient.Client
	callbacks      map[string][]chan string
	mu             sync.RWMutex
}

var (
	_default_pool service_pool
	once          sync.Once
)

func Init(c *cli.Context) {
	once.Do(func() { _default_pool.init(c) })
}

func (p *service_pool) init(c *cli.Context) {
	// init etcd client
	cfg := etcdclient.Config{
		Endpoints: c.StringSlice("etcd-hosts"),
		Transport: etcdclient.DefaultTransport,
	}
	etcdcli, err := etcdclient.New(cfg)
	if err != nil {
		log.Critical(err)
		os.Exit(-1)
	}
	p.client = etcdcli
	p.root = c.String("etcd-root")

	// init
	p.services = make(map[string]*service)
	p.names = make(map[string]bool)

	// names init
	names := c.StringSlice("services")
	if len(names) > 0 {
		p.names_provided = true
	}

	log.Info("all service names:", names)
	for _, v := range names {
		p.names[p.root+"/"+strings.TrimSpace(v)] = true
	}

	// start connection
	p.connect_all(p.root)
}

// connect to all services
func (p *service_pool) connect_all(directory string) {
	kAPI := etcdclient.NewKeysAPI(p.client)
	// get the keys under directory
	log.Info("connecting services under:", directory)
	resp, err := kAPI.Get(context.Background(), directory, &etcdclient.GetOptions{Recursive: true})
	if err != nil {
		log.Error(err)
		return
	}

	// validation check
	if !resp.Node.Dir {
		log.Error("not a directory")
		return
	}

	for _, node := range resp.Node.Nodes {
		if node.Dir { // service directory
			for _, service := range node.Nodes {
				log.Info(service.Key)
				p.add_service(service.Key, service.Value)
			}
		}
	}
	log.Info("services add complete")

	go p.watcher()
}

// watcher for data change in etcd directory
func (p *service_pool) watcher() {
	kAPI := etcdclient.NewKeysAPI(p.client)
	w := kAPI.Watcher(p.root, &etcdclient.WatcherOptions{Recursive: true})
	for {
		resp, err := w.Next(context.Background())
		if err != nil {
			log.Error(err)
			continue
		}
		if resp.Node.Dir {
			continue
		}

		switch resp.Action {
		case "set", "create", "update", "compareAndSwap":
			p.add_service(resp.Node.Key, resp.Node.Value)
		case "delete":
			p.remove_service(resp.PrevNode.Key)
		}
	}
}

// add a service
func (p *service_pool) add_service(key, value string) {
	p.mu.Lock()
	defer p.mu.Unlock()
	// name check
	service_name := filepath.Dir(key)
	if p.names_provided && !p.names[service_name] {
		return
	}
	log.Info(service_name)
	// try new service kind init
	if p.services[service_name] == nil {
		p.services[service_name] = &service{}
	}

	// create service connection
	service := p.services[service_name]

	if conn, err := grpc.Dial(value, grpc.WithBlock(), grpc.WithInsecure(), grpc.WithTimeout(5*time.Second)); err == nil {
		service.clients = append(service.clients, client{key, conn})
		log.Info("service added:", key, "-->", value)
		for k := range p.callbacks[service_name] {
			select {
			case p.callbacks[service_name][k] <- key:
			default:
			}
		}
	} else {
		log.Error("did not connect:", key, "-->", value, "error:", err)
	}
}

// remove a service
func (p *service_pool) remove_service(key string) {
	p.mu.Lock()
	defer p.mu.Unlock()
	// name check
	service_name := filepath.Dir(key)
	if p.names_provided && !p.names[service_name] {
		return
	}

	// check service kind
	service := p.services[service_name]
	if service == nil {
		log.Info("no such service:", service_name)
		return
	}

	// remove a service
	for k := range service.clients {
		if service.clients[k].key == key { // deletion
			service.clients[k].conn.Close()
			service.clients = append(service.clients[:k], service.clients[k+1:]...)
			log.Error("service removed:", key)
			return
		}
	}
}

// provide a specific key for a service, eg:
// path:/backends/snowflake, id:s1
//
// the full cannonical path for this service is:
// 			/backends/snowflake/s1
func (p *service_pool) get_service_with_id(path string, id string) *grpc.ClientConn {
	p.mu.RLock()
	defer p.mu.RUnlock()
	// check existence
	service := p.services[path]
	if service == nil {
		return nil
	}
	if len(service.clients) == 0 {
		return nil
	}

	// loop find a service with id
	fullpath := string(path) + "/" + id
	for k := range service.clients {
		if service.clients[k].key == fullpath {
			return service.clients[k].conn
		}
	}

	return nil
}

// get a service in round-robin style
// especially useful for load-balance with state-less services
func (p *service_pool) get_service(path string) (conn *grpc.ClientConn, key string) {
	p.mu.RLock()
	defer p.mu.RUnlock()
	// check existence
	service := p.services[path]
	if service == nil {
		return nil, ""
	}

	if len(service.clients) == 0 {
		return nil, ""
	}

	// get a service in round-robind style,
	idx := int(atomic.AddUint32(&service.idx, 1)) % len(service.clients)
	return service.clients[idx].conn, service.clients[idx].key
}

func (p *service_pool) register_callback(path string, callback chan string) {
	p.mu.Lock()
	defer p.mu.Unlock()
	if p.callbacks == nil {
		p.callbacks = make(map[string][]chan string)
	}

	p.callbacks[path] = append(p.callbacks[path], callback)
	if s, ok := p.services[path]; ok {
		for k := range s.clients {
			callback <- s.clients[k].key
		}
	}
	log.Info("register callback on:", path)
}

func GetService(path string) *grpc.ClientConn {
	conn, _ := _default_pool.get_service(_default_pool.root + "/" + path)
	return conn
}

func GetService2(path string) (*grpc.ClientConn, string) {
	conn, key := _default_pool.get_service(_default_pool.root + "/" + path)
	return conn, key
}

func GetServiceWithId(path string, id string) *grpc.ClientConn {
	return _default_pool.get_service_with_id(_default_pool.root+"/"+path, id)
}

func RegisterCallback(path string, callback chan string) {
	_default_pool.register_callback(_default_pool.root+"/"+path, callback)
}
