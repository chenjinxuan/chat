import 'package:flutter/material.dart';
import 'package:flutter_app/data_format/contact_object.dart';

class Contacts extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _Contacts();
  }
}

class _Contacts extends State<Contacts> {
  final List<ContactObject> items = [
    new ContactObject(uuid: "u1", name: "蔡志超"),
    new ContactObject(uuid: "u1", name: "蔡志超"),
    new ContactObject(uuid: "u1", name: "蔡志超"),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('${items[index].name}'),
        );
      },
      physics: const AlwaysScrollableScrollPhysics(),
    );
  }
}
