import 'dart:io';

import 'package:flutter_app/config.dart';

class AppWs {
  WebSocket socket;

  AppWs() {
    connect();
  }

  connect() {
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
    print("connectError:$e");
  }

  // 发送消息失败时该方法才会触发
  disconnect(e) {
    print(e);
  }

  reconnect(data) {
    connect();
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
