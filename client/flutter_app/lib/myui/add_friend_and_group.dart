import 'package:flutter/material.dart';

class AddFriendAndGroup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _AddFriendAndGroup();
  }
}

class _AddFriendAndGroup extends State {
  TextEditingController textEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new SimpleDialog(
      title: Center(child: new Text("欢迎")),
      children: <Widget>[
        Container(
          height: 300,
          width: 350,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Flexible(
                child: new TextField(
                  controller: textEditingController,
                ),
//                flex: 3,
              ),
              Flexible(
                child: new RaisedButton(
                  onPressed: () => this.findFriendOrGroup(),
                  child: new Text("清除"),
                ),
//                flex: 1,
              ),
              Flexible(
                child: new RaisedButton(
                  onPressed: () => this.findFriendOrGroup(),
                  child: new Text("搜索"),
                ),
//                flex: 1,
              ),
            ],
          ),
        ),
      ],
    );
  }

  void findFriendOrGroup() {
    print(textEditingController.text);
  }
}
