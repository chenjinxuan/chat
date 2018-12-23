import 'package:flutter/material.dart';
import 'package:flutter_app/data_controller/DataController.dart';

class Contact extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _Contact();
  }
}

class _Contact extends State<Contact> {
  DataController dataController = new DataController();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index) {
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
    });
  }
}
