import 'package:flutter_app/config.dart';
import 'package:flutter_app/data_format/data_format_class.dart';
import 'package:flutter_app/understructure/app_ws.dart';

class DataController {
  factory DataController() => _getInstance();

  static DataController get instance => _getInstance();
  static DataController _instance;

  AppWs a;

  DataController._internal() {
    if (a == null) {
      a = new AppWs(WS_URL);
    }
  }

  static DataController _getInstance() {
    if (_instance == null) {
      _instance = new DataController._internal();
    }
    return _instance;
  }

  List<ContactPeopleItem> listContactPeopleItem = [
    new ContactPeopleItem(title: "大佬1"),
    new ContactPeopleItem(title: "大佬2"),
  ];

  List<TalkMsgItem> listTalkMsgItem = [
    new TalkMsgItem(left: true, head: PORTRAIT, msgUrl: PORTRAIT),
    new TalkMsgItem(left: false, head: PORTRAIT, msgUrl: null, txt: "啊哈哈哈哈"),
  ];

  ContactPeopleItem retContactsItem(int index) {
    if (index < listContactPeopleItem.length) {
      return listContactPeopleItem[index];
    }
  }

  TalkMsgItem retTalkMsgItem(int index) {
    if (index < listTalkMsgItem.length) {
      return listTalkMsgItem[index];
    }
  }
}
