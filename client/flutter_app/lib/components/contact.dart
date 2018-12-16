import 'package:flutter/material.dart';

class Contact extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _Contact();
  }
}

class _Contact extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index) {
      return new ListTile(
        leading: Image.network(
          "http://5b0988e595225.cdn.sohucs.com/images/20171121/ea654bd7837844ab83419d647ec5d373.jpeg",
          width: 50.0,
          height: 50.0,
          fit: BoxFit.cover,
        ),
        title: new Text("班主任"),
        subtitle: new Text("你高考考了满分你知道吗？"),
        trailing: new Text("9:00"),
      );
    });
  }
}
