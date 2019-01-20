import 'package:flutter_app/config.dart';
import 'package:flutter_app/data_controller/debug_data.dart';
import 'package:flutter_app/data_format/data_format_class.dart';
import 'package:flutter_app/understructure/app_ws.dart';

class DataController {
  /*
 单例模式
 */
  factory DataController() => _getInstance();

  static DataController get instance => _getInstance();
  static DataController _instance;

  static DataController _getInstance() {
    if (_instance == null) {
      _instance = new DataController._internal();
    }
    return _instance;
  }

/*
业务逻辑
 */
  AppWs a;

  DataController._internal() {
    if (a == null) {
      a = new AppWs(WS_URL);
    }
    if(IS_DEBUG){
      this.listContactPeopleItem = debugListContactPeopleItem;
          this.listTalkMsgItem = debugListTalkMsgItem;
    }
  }

  List<ContactPeopleItem> listContactPeopleItem = [];

  List<TalkMsgItem> listTalkMsgItem = [];

  void addTalkMsgItem(TalkMsgItem t) {
    this.listTalkMsgItem.add(t);
    this.listTalkMsgItem.sort((a, b) => b.saveTime.compareTo(a.saveTime));
  }

  ContactPeopleItem retContactsItem(int index) {
    if (index < listContactPeopleItem.length) {
      return listContactPeopleItem[index];
    }
  }

  TalkMsgItem retTalkMsgItem(int index) {
    if (index < listTalkMsgItem.length) {
      return listTalkMsgItem[index];
    }
//    return listTalkMsgItem[0];
  }
}
