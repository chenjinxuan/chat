import 'package:flutter/material.dart';
import 'package:flutter_app/myui/add_friend_and_group.dart';
import 'package:flutter_app/myui/contact.dart';
import 'package:flutter_app/myui/login_page.dart';
import 'package:flutter_app/myui/talk_session.dart';
import 'package:flutter_app/data_format/data_format_class.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  MyApp() {}

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new MainLook(),
    );
  }
}

class MainLook extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _MainLook();
  }
}

class _MainLook extends State<MainLook> {
  int _currentPageIndex = 0;
  var _pageController = new PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title:
            new Text("爱学习专用信息传递装置", style: new TextStyle(color: Colors.white)),
        iconTheme: new IconThemeData(color: Colors.white),
        actions: <Widget>[
          new PopupMenuButton<AppBarChoice>(
            // overflow menu
            onSelected: _onAppBarSelected,
            itemBuilder: (BuildContext context) {
              return choices.map((AppBarChoice choice) {
                return new PopupMenuItem<AppBarChoice>(
                  value: choice,
                  child: new Text(choice.title),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: new PageView.builder(
        itemBuilder: (BuildContext context, int index) {
          switch (index) {
            case 0:
              return new LoginPage();
            case 1:
              return new Contact();
            case 2:
              return new TalkSession();
          }
        },
        controller: _pageController,
        onPageChanged: _onPageChanged,
        itemCount: listBottomBar.length,
      ),
      bottomNavigationBar: new BottomNavigationBar(
        items: listBottomBar,
        onTap: bottomBarOnTap,
        currentIndex: _currentPageIndex,
      ),
    );
  }

  // 点击下方三个按钮进行跳转
  bottomBarOnTap(int index) {
//    _pageController.animateToPage(
//      index,
//      duration: const Duration(milliseconds: 300),
//      curve: Curves.ease,
//    );
    _pageController.jumpToPage(index);
  }

  _onPageChanged(int index) {
    setState(() {
      if (index != _currentPageIndex) {
        _currentPageIndex = index;
      }
    });
  }

  // 跳转到加好友和加群界面
  _onAppBarSelected(AppBarChoice item) {
    if (item.buttonType == AppBarChoiceEnum.addFriendAndGroup) {
      showDialog(
        context: context,
        builder: (context) {
          return new AddFriendAndGroup();
        },
      );
    }
  }
}

List<BottomNavigationBarItem> listBottomBar = [
  new BottomNavigationBarItem(
    icon: new Icon(Icons.brightness_5),
    title: new Title(
      title: "",
      child: new Text("登陆"),
      color: Colors.blueAccent,
    ),
  ),
  new BottomNavigationBarItem(
    icon: new Icon(Icons.contact_mail),
    title: new Title(
      title: "",
      child: new Text("联系人"),
      color: Colors.amber,
    ),
  ),
  new BottomNavigationBarItem(
    icon: new Icon(Icons.history),
    title: new Title(
      title: "",
      child: new Text("会话"),
      color: Colors.amber,
    ),
  ),
];

const List<AppBarChoice> choices = const <AppBarChoice>[
  const AppBarChoice(
      buttonType: AppBarChoiceEnum.addFriendAndGroup,
      title: '加群加好友',
      icon: Icons.directions_car),
  const AppBarChoice(
      buttonType: AppBarChoiceEnum.other,
      title: '待添加',
      icon: Icons.directions_bike),
];
