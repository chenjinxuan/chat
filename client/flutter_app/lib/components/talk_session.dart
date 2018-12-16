import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/image_zoomable.dart';

String portrait =
    "http://5b0988e595225.cdn.sohucs.com/images/20171121/ea654bd7837844ab83419d647ec5d373.jpeg";

Widget getHead(String imgUrl) {
  return new Container(
    margin: const EdgeInsets.only(right: 16.0, left: 16.0),
    child: new CircleAvatar(backgroundImage: new NetworkImage(imgUrl)),
  );
}

Widget getMsg(context, String imgUrl) {
  Widget candidate;
  if (imgUrl != "") {
    candidate = new Container(
      margin: const EdgeInsets.only(top: 5.0),
      child: new GestureDetector(
        onTap: () {
          Navigator.of(context).push(
              new MaterialPageRoute<Null>(builder: (BuildContext context) {
            return new ImageZoomable(
              new NetworkImage(imgUrl),
              onTap: () {
                Navigator.of(context).pop();
              },
            );
          }));
        },
        child: new Image.network(
          imgUrl,
          width: 150.0,
        ),
      ),
    );
  } else {
    candidate = new Text(
      "聊天内容123123123",
      style: Theme.of(context).textTheme.body2,
    );
  }

  return Flexible(
      child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
        new Text(
          "蔡志超",
          style: Theme.of(context).textTheme.subhead,
        ),
        candidate,
      ]));
}

Widget _sheSessionMsgState(
    BuildContext context, String headImgUrl, String msgImgUrl) {
  return new Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        getHead(headImgUrl),
        getMsg(context, msgImgUrl),
      ]);
}

Widget _mySessionMsgState(
    BuildContext context, String headImgUrl, String msgImgUrl) {
  return new Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        getMsg(context, msgImgUrl),
        getHead(headImgUrl),
      ]);
}

class TalkSession extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    _TalkSession s = new _TalkSession();
    return s;
  }
}

class _TalkSession extends State<TalkSession> {
  ScrollController scrollController = new ScrollController();

  Widget getButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        new FloatingActionButton(
          onPressed: () => goToEnd(),
          tooltip: '跳到最后一条消息',
          child: new Icon(Icons.arrow_downward),
        ),
      ],
    );
  }

  Widget getMsgListView() {
    return new ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        if (index % 2 == 0) {
          return _sheSessionMsgState(context, portrait, portrait);
        } else {
          return _mySessionMsgState(context, portrait, "");
        }
      },
      itemCount: 10,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(6.0),
      controller: scrollController,
    );
  }

  Widget getInputArea() {
    return new Row(
      children: <Widget>[
        new Flexible(
          child: new TextField(
            style: Theme.of(context).textTheme.body1,
          ),
        ),
        new RaisedButton(
          onPressed: () => {},
          child: new Text("发送"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        getButton(),
        new Flexible(
          child: getMsgListView(),
        ),
        getInputArea(),
      ],
    );
  }

  void goToEnd() {
    // todo 跳转到最后一条聊天记录还不知道怎么做
    scrollController.animateTo(
      10000.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}
