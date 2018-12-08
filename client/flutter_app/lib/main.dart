import 'package:flutter/material.dart';
import 'package:flutter_app/LoginPage.dart';
import 'package:flutter_app/understructure/app_ws.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  AppWs s;

  MyApp() {
    s = new AppWs();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(home: new LoginPage());
  }
}
