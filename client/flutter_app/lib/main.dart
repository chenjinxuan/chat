import 'package:flutter/material.dart';
import 'package:flutter_app/components/contact.dart';
import 'package:flutter_app/components/login_page.dart';
import 'package:flutter_app/components/talk_session.dart';

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
          return null;
        },
        controller: _pageController,
        onPageChanged: _onPageChanged,
      ),
      bottomNavigationBar: new BottomNavigationBar(
        items: <BottomNavigationBarItem>[
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
        ],
        onTap: onTap,
        currentIndex: _currentPageIndex,
      ),
    );
  }

  onTap(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  _onPageChanged(int index) {
    setState(() {
      if (index != _currentPageIndex) {
        _currentPageIndex = index;
      }
    });
  }
}
