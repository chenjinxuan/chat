import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/data_controller/DataController.dart';
import 'package:flutter_app/myui/image_zoomable.dart';

Widget getHead(String imgUrl) {
  return new Container(
    margin: const EdgeInsets.only(right: 16.0, left: 16.0),
    child: new CircleAvatar(backgroundImage: new NetworkImage(imgUrl)),
  );
}

Widget getMsg(context, String imgUrl, String txt) {
  Widget candidate;
  if (imgUrl != null) {
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
  } else if (txt != null) {
    candidate = new Text(
      txt,
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
    BuildContext context, String headImgUrl, String msgImgUrl, String txt) {
  return new Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        getHead(headImgUrl),
        getMsg(context, msgImgUrl, txt),
      ]);
}

Widget _mySessionMsgState(
    BuildContext context, String headImgUrl, String msgImgUrl, String txt) {
  return new Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        getMsg(context, msgImgUrl, txt),
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
  DataController dataController = new DataController();

  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        // 一个暂时没用到的按钮
//        getButton(),
        new Flexible(
          child: getMsgListView(),
        ),
        getInputArea(),
      ],
    );
  }

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
        var c = dataController.retTalkMsgItem(index);
        if (c != null) {
          if (c.left) {
            return _sheSessionMsgState(context, c.head, c.msgUrl, null);
          } else {
            return _mySessionMsgState(context, c.head, null, c.txt);
          }
        }
      },
      itemCount: 10,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(6.0),
      controller: scrollController,
      reverse: true,
      shrinkWrap: true,
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

  void goToEnd() {
    throw Error();
//    scrollController.animateTo(
//      10000.0,
//      duration: const Duration(milliseconds: 300),
//      curve: Curves.easeOut,
//    );
//    scrollController.jumpTo(10000.0);
  }
}
