# chat

### 涉及技术

 1. 通讯协议 对外使用ws 后续支持tcp,kcp, 对内使用 grpc
 2. 通讯数据协议 使用protobuf
 3. 采用etcd进行服务发现及配置下发
 4. 采用redis来存储离线消息
 5. mysql用来存储账号体系
 6. 采用nsq来做一些异步任务
 7. 采用logkit做日志收集,kafka做日志传输,elasticsearch做日志存储
 8. docker部署



