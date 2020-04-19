import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:simonchat/tabs/chat.dart';
import 'package:simonchat/tabs/find.dart';
import 'package:simonchat/tabs/me.dart';
import 'package:simonchat/tabs/people.dart';
import 'package:simonchat/widgets/bottom_menu.dart';

List<Map<String, dynamic>> _tabs = [
  {
    "title": "聊天",
    "icon": Icons.chat_bubble_outline,
    "activeIcon": Icons.chat_bubble,
    "widget": ChatPage(),
    "titleShow": true,
  },
  {
    "title": "通讯录",
    "icon": Icons.people_outline,
    "activeIcon": Icons.people,
    "widget": PeoplePage(),
    "titleShow": true,
  },
  {
    "title": "发现",
    "icon": Icons.pie_chart_outlined,
    "activeIcon": Icons.pie_chart,
    "widget": FindPage(),
    "titleShow": true,
  },
  {
    "title": "我的",
    "icon": Icons.person_outline,
    "activeIcon": Icons.person,
    "widget": MePage(),
    "titleShow": false,
  }
];

class LayoutPage extends StatefulWidget {
  @override
  _LayoutPageState createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  int current;
  PageController _controller;

  @override
  void initState() {
    // TODO: implement initState
    current = 0;
    _controller = PageController(initialPage: current);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var currentTab = _tabs[current];
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: currentTab["titleShow"]
          ? AppBar(
              title: Text(currentTab["title"]),
              actions: buildAppBarActions(),
            )
          : null,
      body: PageView(
        onPageChanged: (page) {
          setState(() {
            current = page;
          });
        },
        controller: _controller,
        children: _tabs.map<Widget>((tab) => tab["widget"]).toList(),
      ),
      bottomNavigationBar: BottomMenuBar(
        currentIndex: current,
        onChange: (i) {
          setState(() {
            current = i;
            _controller.jumpToPage(current);
          });
        },
        children: _tabs
            .map<BottomMenu>(
              (tab) => BottomMenu(
                icon: tab["icon"],
                activeIcon: tab["activeIcon"],
                title: tab["title"],
              ),
            )
            .toList(),
      ),
    );
  }

  buildAppBarActions() {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () {},
      ),
      PopupMenuButton(
        icon: Icon(Icons.more_vert),
        color: Color.fromRGBO(0, 0, 0, .8),
        itemBuilder: (BuildContext context) {
          return <PopupMenuEntry<dynamic>>[
            PopupMenuItem(
              textStyle: TextStyle(color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.chat,
                    color: Colors.white,
                  ),
                  SizedBox(width: 10.0),
                  Text("发起群聊")
                ],
              ),
              value: "start group chat",
            ),
            PopupMenuItem(
              textStyle: TextStyle(color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.person_add,
                    color: Colors.white,
                  ),
                  SizedBox(width: 10.0),
                  Text("添加好友")
                ],
              ),
              value: "add friend",
            ),
            PopupMenuItem(
              textStyle: TextStyle(color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.crop_free,
                    color: Colors.white,
                  ),
                  SizedBox(width: 10.0),
                  Text("扫一扫")
                ],
              ),
              value: "sao yi sao",
            ),
            PopupMenuItem(
              textStyle: TextStyle(color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.payment,
                    color: Colors.white,
                  ),
                  SizedBox(width: 10.0),
                  Text("收付款")
                ],
              ),
              value: "hot",
            ),
            PopupMenuItem(
              textStyle: TextStyle(color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.help,
                    color: Colors.white,
                  ),
                  SizedBox(width: 10.0),
                  Text("帮助与反馈")
                ],
              ),
              value: "hot",
            ),
          ];
        },
      ),
    ];
  }
}
