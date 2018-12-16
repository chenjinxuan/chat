import 'package:flutter/material.dart';
import 'package:flutter_app/main_look.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  MyApp() {}

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new MainLook(),
    );
  }
}
