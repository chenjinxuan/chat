import 'package:flutter/material.dart';
import 'package:flutter_app/data_controller/data_controller.dart';

class Contact extends StatefulWidget {
  bool isShowSearchBar = false;

  @override
  State<StatefulWidget> createState() {
    return new _Contact(isShowSearchBar);
  }

  showSearchBar() {
    print("显示联系人搜索框");
    isShowSearchBar = true;
  }
}

class _Contact extends State<Contact> {
  DataController dataController = new DataController();
  bool isShowSearchBar = false;
  TextEditingController textEditingController = new TextEditingController();

  _Contact(this.isShowSearchBar);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        renderSearchBar(),
        Flexible(
          child: ListView.builder(itemBuilder: (context, index) {
            var c = dataController.retContactsItem(index);
            if (c == null) {
              return null;
            }
            return new ListTile(
              leading: Image.network(
                c.leadingImageUrl,
                width: 50.0,
                height: 50.0,
                fit: BoxFit.cover,
              ),
              title: new Text(c.title),
              subtitle: new Text(c.subtitle),
              trailing: new Text(c.trailing),
            );
          }),
        ),
      ],
    );
  }

  renderSearchBar() {
    if (isShowSearchBar) {
      return new Row(
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
      );
    } else {
      return new Container(height: 0.0, width: 0.0);
    }
  }

  void findFriendOrGroup() {
    print(textEditingController.text);
  }
}
