//作者：间歇性丶神经病患者
//链接：https://www.jianshu.com/p/9ecfe2695e5e
//來源：简书
//简书著作权归作者所有，任何形式的转载都请联系作者获得授权并注明出处。

import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  var leftRightPadding = 30.0;
  var topBottomPadding = 4.0;
  var textTips = new TextStyle(fontSize: 16.0, color: Colors.black);
  var hintTips = new TextStyle(fontSize: 15.0, color: Colors.black26);
  static const LOGO = "images/golang.png";

  var _userPassController = new TextEditingController();
  var _userNameController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        new Padding(
          padding: new EdgeInsets.fromLTRB(
              leftRightPadding, 50.0, leftRightPadding, 10.0),
//          child: new Image.asset(LOGO),
        ),
        new Padding(
          padding: new EdgeInsets.fromLTRB(
              leftRightPadding, 50.0, leftRightPadding, topBottomPadding),
          child: new TextField(
            style: hintTips,
            controller: _userNameController,
            decoration: new InputDecoration(hintText: "请输入用户名"),
            obscureText: true,
          ),
        ),
        new Padding(
          padding: new EdgeInsets.fromLTRB(
              leftRightPadding, 30.0, leftRightPadding, topBottomPadding),
          child: new TextField(
            style: hintTips,
            controller: _userPassController,
            decoration: new InputDecoration(hintText: "请输入用户密码"),
            obscureText: true,
          ),
        ),
        new Container(
          width: 360.0,
          margin: new EdgeInsets.fromLTRB(10.0, 40.0, 10.0, 0.0),
          padding: new EdgeInsets.fromLTRB(leftRightPadding, topBottomPadding,
              leftRightPadding, topBottomPadding),
          child: new Card(
            color: Colors.green,
            elevation: 6.0,
            child: new FlatButton(
                onPressed: () {
                  print("the pass is" + _userNameController.text);
                },
                child: new Padding(
                  padding: new EdgeInsets.all(10.0),
                  child: new Text(
                    '马上登录',
                    style: new TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                )),
          ),
        )
      ],
    );
  }
}
