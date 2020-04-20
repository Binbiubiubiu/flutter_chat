import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simonchat/mock/people.dart';

class PeoplePage extends StatefulWidget {
  @override
  _PeoplePageState createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CustomScrollView(
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
                  if (peopleMock[index]["group"] != null) {
                    return buildWordBlock(peopleMock[index]["group"]);
                  }

                  return DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: ListTile(
                      leading: Container(
                        width: 34.0,
                        height: 34.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(peopleMock[index]["avatar"]),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      title: Text("新朋友"),
                    ),
                  );
                },
                childCount: peopleMock.length,
              ),
            )
          ],
        ),
        buildWordIndex(),
      ],
    );
  }

  buildWordIndex() {
    List<String> words = [
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
      "#",
    ];
    return Positioned(
      top: 0,
      right: 0,
      bottom: 0,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: words.map((word) => Text(word)).toList(),
        ),
      ),
    );
  }

  buildWordBlock(String word) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Text(
        word,
        style: TextStyle(color: Colors.black54),
      ),
    );
  }
}
