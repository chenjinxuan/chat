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
    return Scaffold(
      appBar: new AppBar(),
      body: new Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            child: new TextField(
              controller: textEditingController,
            ),
//                flex: 3,
          ),
          new RaisedButton(
            onPressed: () =>  textEditingController.clear(),
            child: new Icon(Icons.clear),
            shape: CircleBorder(),
            color: Colors.blue,
          ),
          new RaisedButton(
            onPressed: () => this.findFriendOrGroup(),
            child: new Text("搜索"),
          ),
        ],
      ),
    );
  }

  void findFriendOrGroup() {
    print(textEditingController.text);
  }
}
