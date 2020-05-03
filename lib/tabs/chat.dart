import 'dart:math' as Math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Map<String, dynamic>> _list;

  @override
  void initState() {
    // TODO: implement initState
    _list = List.generate(30, (int index) {
      return {
        "title": "前端${index}",
        "subTitle": "害怕${index}",
        "isReaded": false
      };
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (BuildContext context, int i) {
        return GestureDetector(
          onLongPressStart: (LongPressStartDetails details) {
            _showMenu(details, i);
          },
          child: DecoratedBox(
            decoration: BoxDecoration(color: Colors.white),
            child: ListTile(
              onTap: () {},
              leading: Stack(
                children: <Widget>[
                  FlutterLogo(
                    size: 40,
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Transform.translate(
                      offset: Offset(5.0, -2.0),
                      child: Container(
                        width: 10.0,
                        height: 10.0,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              title: Text(
                _list[i]["title"],
                style: TextStyle(fontSize: 16.0),
              ),
              subtitle: Text(_list[i]["subTitle"]),
              trailing: Column(
                children: <Widget>[
                  Text("昨天", style: TextStyle(fontSize: 12.0)),
                  SizedBox(height: 10.0),
                  Visibility(
                    visible: _list[i]["isReaded"],
                    child: Icon(Icons.notifications_off, size: 16.0),
                  )
                ],
              ),
              dense: true,
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int i) => Divider(height: 0),
      itemCount: _list.length,
    );
  }

  _showMenu(LongPressStartDetails details, int index) {
    double globalPositionX = details.globalPosition.dx;
    double globalPositionY = details.globalPosition.dy;

    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    double height = overlay.size.height - kBottomNavigationBarHeight * 2;

    List<PopupMenuEntry<String>> items = _buildMenuItem();

    showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        globalPositionX,
        Math.min(
            globalPositionY, height - kMinInteractiveDimension * items.length),
        overlay.size.width,
        overlay.size.height - kBottomNavigationBarHeight * 2,
      ),
      items: items,
    ).then((action) {
      _menuAction(action, index);
    });
  }

  _menuAction(String action, int current) {
    setState(() {
      switch (action) {
        case "unRead":
          _list[current]["isReaded"] = true;
          break;
        case "top":
          var el = _list[current];
          _list.removeAt(current);
          _list.insert(0, el);
          break;
        case "delete":
          _list.removeAt(current);
          break;
        default:
          break;
      }
    });
  }

  List<PopupMenuEntry<String>> _buildMenuItem() {
    return <PopupMenuItem<String>>[
      PopupMenuItem(
        child: Text("标记未读"),
        value: "unRead",
      ),
      PopupMenuItem(
        child: Text("置顶聊天"),
        value: "top",
      ),
      PopupMenuItem(
        child: Text("删除该聊天"),
        value: "delete",
      ),
    ];
  }
}
