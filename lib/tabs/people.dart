import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:simonchat/mock/people.dart';
import 'dart:math' as Math;

List<String> _indexWord = [
  "↑",
  "☆",
  "A",
  "B",
  "C",
  "D",
  "E",
  "F",
  "G",
  "H",
  "I",
  "J",
  "K",
  "L",
  "M",
  "N",
  "O",
  "P",
  "Q",
  "R",
  "S",
  "T",
  "U",
  "V",
  "W",
  "X",
  "Y",
  "Z",
  "#"
];

const WORD_SIZE = 18.0;

const TAIL_SIZE = 56.0;

const GROUP_WORD_SIZE = 30.0;

Map<String, dynamic> computedGroupTop() {
  double hasTop = TAIL_SIZE * 4;
  Map<String, dynamic> heightList = {
    '↑': {"top": 0.0, "height": 0.0},
    '☆': {"top": 0.0, "height": 0.0},
  };
  for (var i = 0; i < peopleMock.length; i++) {
    var group = peopleMock[i];

    double height =
        GROUP_WORD_SIZE + (group["people"] as List<dynamic>).length * TAIL_SIZE;
    heightList[group["group"]] = {"top": hasTop, "height": height};
    hasTop += height;
  }
  return heightList;
}

class PeoplePage extends StatefulWidget {
  @override
  _PeoplePageState createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage> {
  GlobalKey _myKey = new GlobalKey();
  ScrollController _controller = new ScrollController();
  Map<String, dynamic> _heights;
  List<dynamic> _listItem = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _heights = computedGroupTop();
      peopleMock.forEach((group) {
        _listItem.add({"group": group["group"]});
        _listItem.addAll(group["people"]);
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CustomScrollView(
          key: _myKey,
          controller: _controller,
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Column(
                children: <Widget>[
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: ListTile(
                      leading: Container(
                        width: 34.0,
                        height: 34.0,
                        decoration: BoxDecoration(
                          color: Color(0xFFECA14F),
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.person_add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      title: Text("新朋友"),
                    ),
                  ),
                  Divider(height: 0.0),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: ListTile(
                      leading: Container(
                        width: 34.0,
                        height: 34.0,
                        decoration: BoxDecoration(
                          color: Color(0xFF58BF6B),
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.people,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      title: Text("群聊"),
                    ),
                  ),
                  Divider(height: 0.0),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: ListTile(
                      leading: Container(
                        width: 34.0,
                        height: 34.0,
                        decoration: BoxDecoration(
                          color: Color(0xFF427FD1),
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.bookmark,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      title: Text("标签"),
                    ),
                  ),
                  Divider(height: 0.0),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: ListTile(
                      leading: Container(
                        width: 34.0,
                        height: 34.0,
                        decoration: BoxDecoration(
                          color: Color(0xFF427FD1),
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      title: Text("公众号"),
                    ),
                  ),
                  Divider(height: 0.0),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  if (_listItem[index]["group"] != null) {
                    return buildWordBlock(_listItem[index]["group"]);
                  }

                  return DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: ListTile(
                      leading: Container(
                        width: 30.0,
                        height: 30.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(_listItem[index]["avatar"]),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      title: Text("新朋友"),
                    ),
                  );
                },
                childCount: _listItem.length,
              ),
            )
          ],
        ),
        buildWordIndex(),
      ],
    );
  }

  buildWordIndex() {
    return Positioned(
      top: 0,
      right: 0,
      bottom: 0,
      child: Container(
        alignment: Alignment.center,
        child: GestureDetector(
          onTapDown: (TapDownDetails details) {
            moveToWord(details.localPosition.dy);
          },
          onPanUpdate: (DragUpdateDetails details) {
            moveToWord(details.localPosition.dy);
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: _indexWord
                .map(
                  (word) => SizedBox(
                    width: WORD_SIZE + 20,
                    height: WORD_SIZE,
                    child: Center(
                      child: Text(word),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  moveToWord(double y) {
    int i = (y / WORD_SIZE).floor();
    String word = _indexWord[i];
    double scrollHeight = _controller.position.maxScrollExtent;

    if (_heights[word] != null) {
      _controller.jumpTo(Math.min(_heights[word]["top"], scrollHeight));
    }
  }

  buildWordBlock(String word) {
    return Container(
      height: 30.0,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        word,
        style: TextStyle(color: Colors.black54),
      ),
    );
  }
}
