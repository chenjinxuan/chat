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
      contentPadding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      children: <Widget>[
        Column(
          children: <Widget>[
            new Row(
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
                  onPressed: () => this.findFriendOrGroup(),
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
            Container(
              height: 400.0,
            ),
          ],
        ),
      ],
    );
  }

  void findFriendOrGroup() {
    print(textEditingController.text);
  }
}
