package main

import (
	. "chat/agent/types"
	"chat/common/log"
	"chat/common/utils"
	"github.com/gorilla/websocket"
	"gopkg.in/urfave/cli.v2"
	"net"
	"net/http"
	_ "net/http/pprof"
	"os"
	"time"
)

var config *Config

type Config struct {
	wslisten     string
	txqueuelen   int
	readDeadline time.Duration
}

func main() {

	// to catch all uncaught panic
	defer utils.PrintPanicStack()

	// open profiling
	go http.ListenAndServe("0.0.0.0:6060", nil)
	app := &cli.App{
		Name:    "agent",
		Usage:   "a gateway for chat with stream multiplexing",
		Version: "0.1",
		Flags: []cli.Flag{
			&cli.StringFlag{
				Name:  "ws-listen",
				Value: ":8899",
				Usage: "websocket listening address:port",
			},
			&cli.StringSliceFlag{
				Name:  "etcd-hosts",
				Value: cli.NewStringSlice("http://119.29.67.61:2379"),
				Usage: "etcd hosts",
			},
			&cli.StringFlag{
				Name:  "etcd-root",
				Value: "/server",
				Usage: "etcd root path",
			},
			&cli.StringSliceFlag{
				Name:  "services",
				Value: cli.NewStringSlice("chat", "user_center"),
				Usage: "auto-discovering services",
			},
			&cli.DurationFlag{
				Name:  "read-deadline",
				Value: 15 * time.Second,
				Usage: "per connection read timeout",
			},
			&cli.IntFlag{
				Name:  "txqueuelen",
				Value: 128,
				Usage: "per connection output message queue, packet will be dropped if exceeds",
			},
		},
		Action: func(c *cli.Context) error {
			log.Info("wslisten:", c.String("ws-listen"))
			log.Info("etcd-hosts:", c.StringSlice("etcd-hosts"))
			log.Info("etcd-root:", c.String("etcd-root"))
			log.Info("services:", c.StringSlice("services"))
			log.Info("read-deadline:", c.Duration("read-deadline"))

			//setup net param
			config = &Config{
				wslisten:     c.String("ws-listen"),
				readDeadline: c.Duration("read-deadline"),
				txqueuelen:   c.Int("txqueuelen"),
			}

			// init services
			startup(c)

			// wait forever
			select {}
		},
	}
	app.Run(os.Args)
}

var upgrader = websocket.Upgrader{
	ReadBufferSize:  10240,
	WriteBufferSize: 10240,
}

func wsServer() {
	http.HandleFunc("/", wsHandler)

	if err := http.ListenAndServe(config.wslisten, nil); err != nil {
		log.Error("ListenAndServe:", err)
	}
}

func wsHandler(w http.ResponseWriter, r *http.Request) {
	ws, err := upgrader.Upgrade(w, r, nil)
	if err != nil {
		log.Error("websocket connect error =>", err)
		return
	}

	handleClient(ws)
}

func handleClient(conn *websocket.Conn) {
	defer utils.PrintPanicStack()
	defer conn.Close()
	in := make(chan []byte)
	defer func() {
		close(in) // session will close
	}()

	var sess Session
	host, port, err := net.SplitHostPort(conn.RemoteAddr().String())
	if err != nil {
		log.Error("cannot get remote address:", err)
		return
	}
	sess.IP = net.ParseIP(host)
	log.Infof("new connection from:%v port:%v", host, port)
	sess.Die = make(chan struct{})

	// create a write buffer
	out := new_buffer(conn, sess.Die, config.txqueuelen)
	go out.start()

	// start agent for PACKET processing
	wg.Add(1)
	go agent(&sess, in, out)

	// read loop
	for {
		//set timeout
		conn.SetReadDeadline(time.Now().Add(config.readDeadline))
		_, payload, err := conn.ReadMessage()
		if err != nil {
			log.Error(err)
			return
		}
		//传入队列
		select {
		case in <- payload: // payload queued
		case <-sess.Die:
			log.Warnf("connection closed by logic, flag:%v ip:%v", sess.Flag, sess.IP)
			return
		}
	}
}
