import 'dart:io';

class AppWs {
  WebSocket socket;
  String wsUrl;
  AppWs(String wsUrl) {
    this.wsUrl = wsUrl;
    connect(this.wsUrl);
  }

  connect(String wsUrl) {
    WebSocket.connect(wsUrl).then((socket) {
      this.socket = socket;
      socket.listen((data) {
        receive(data);
      });
      socket.done.then((e) {
        disconnect(e);
      });
    }).catchError((e) => connectError(e));
  }

  //当与服务器连接中断调用
  connectError(e) {
    print("connectError:$e:url:" + this.wsUrl);
  }

  // 发送消息失败时该方法才会触发
  disconnect(e) {
    print(e);
  }

  reconnect(data) {
    connect(this.wsUrl);
  }

  //该方法接收服务器信息
  receive(data) {
    print(data);
  }

  send(s) {
    print(s);
    this.socket.add(s.toString());
  }

  close() {
    this.socket.close();
  }
}
