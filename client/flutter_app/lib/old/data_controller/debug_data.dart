import 'package:flutter_app/config.dart';
import 'package:flutter_app/data_format/data_format_class.dart';

List<ContactPeopleItem> debugListContactPeopleItem = [
  new ContactPeopleItem(title: "大佬1"),
  new ContactPeopleItem(title: "大佬2"),
];

List<TalkMsgItem> debugListTalkMsgItem = [
  new TalkMsgItem(
      left: false, head: PORTRAIT, msgUrl: null, txt: "啊哈哈哈哈我是测试数据", saveTime: 22),
  new TalkMsgItem(
    left: true,
    head: PORTRAIT,
    msgUrl: PORTRAIT,
    saveTime: 11,
  )
];
