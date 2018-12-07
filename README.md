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


### 主要服务
1. api服务 主要提供http请求,获取用户信息,登录注册,提供agent列表地址,
2. agent服务 网关,提供socket链接 前期先支持ws即可,转发用户的数据
3. chat服务 聊天服务,用户聊天的数据交换服
4. usercneter服务 用户中心, 权限校验,用户信息管理,比如在线状态


### 用户使用流程
1.  从api服务登录,获取token,和agent地址
2. 连接agent,agent通过token请求usercenter进行权限校验.校验通过则获取chat服务id,从etcd获取chat地址,
   建立chat的转发通道. 若权限校验失败则断开连接返回特定状态码
3. chat服与agent建立通道后,需要告诉客户端聊天服务准备就绪,并且通知usercenter更新用户信息状态. 最后处理用户发过来的信息
4. 互体机制,分为三种客户端, pc,mobile,web,,, 每种客户端同时只能有一个客户端在线,新踢旧, 用户的聊天信息三端同步,这个由usercenter控制
5.  群聊机制,群聊成员地址由usercenter存储,chat在收到群聊信息之后,需要带着群聊id向usercenter获取所有在线用户,并且存储离线消息
6. 离线消息,服务端需要存储每个消息是否已读,离线时间,可配置
7. 每个服务的配置文件都由etcd获取,服务暴露的地址也由etcd提供 也就是服务发现功能

### 移动端
1. 使用谷歌爸爸最新一代跨平台框架 flutter 开发。
2. 前期就简单的加加好友，单人聊天，开个群聊，只发送文字这样纸。
3. 使用ws、http进行数据传递，使用设备码和手机号登陆，不麻烦的话再支持第三方登陆。

### google 文档地址
https://docs.google.com/document/d/1Cm3wB8Fvoc47MIjLHOuxT_ISAqLtDzApN7Pu3n1qxe8/edit

### trello地址
https://trello.com/b/n079Ow6n/chat
