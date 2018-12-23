import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

const String _s1 =
    "http://5b0988e595225.cdn.sohucs.com/images/20171121/ea654bd7837844ab83419d647ec5d373.jpeg";
const String _s2 = "班主任";
const String _s3 = "你高考考了满分你知道吗";
const String _s4 = "9:00";

class ContactPeopleItem {
  String leadingImageUrl;

  String title;
  String subtitle;

  String trailing;

  ContactPeopleItem({
    this.leadingImageUrl = _s1,
    this.title = _s2,
    this.subtitle = _s3,
    this.trailing = _s4,
  });
}

class TalkMsgItem {
  bool left;
  String head;
  String msgUrl;
  String txt;

  TalkMsgItem({
    @required this.left,
    this.head,
    this.msgUrl,
    this.txt,
  });
}

class AppBarChoice {
  const AppBarChoice({this.title, this.icon});

  final String title;
  final IconData icon;
}
