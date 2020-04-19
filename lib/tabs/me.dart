import 'package:flutter/material.dart';

class MePage extends StatefulWidget {
  @override
  _MePageState createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  @override
  Widget build(BuildContext context) {
    final kStatusBarHeight = MediaQuery.of(context).padding.top;
    return Stack(
      children: <Widget>[
        CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Column(
                children: <Widget>[
                  buildUserHeader(kStatusBarHeight),
                  SizedBox(height: 10.0),
                  DecoratedBox(
                    decoration: BoxDecoration(color: Colors.white),
                    child: ListTile(
                      onTap: () {},
                      leading: Icon(Icons.payment),
                      title: Text("支付"),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  DecoratedBox(
                    decoration: BoxDecoration(color: Colors.white),
                    child: ListTile(
                      onTap: () {},
                      leading: Icon(Icons.inbox),
                      title: Text("收藏"),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(color: Colors.white),
                    child: ListTile(
                      onTap: () {},
                      leading: Icon(Icons.photo_library),
                      title: Text("相册"),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(color: Colors.white),
                    child: ListTile(
                      onTap: () {},
                      leading: Icon(Icons.card_membership),
                      title: Text("卡包"),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(color: Colors.white),
                    child: ListTile(
                      onTap: () {},
                      leading: Icon(Icons.face),
                      title: Text("表情"),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  DecoratedBox(
                    decoration: BoxDecoration(color: Colors.white),
                    child: ListTile(
                      onTap: () {},
                      leading: Icon(Icons.settings),
                      title: Text("设置"),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        Positioned(
          top: kStatusBarHeight + 10,
          right: 20,
          child: GestureDetector(
            child: Icon(
              Icons.photo_camera,
              color: Colors.black,
              size: 26.0,
            ),
          ),
        ),
      ],
    );
  }

  buildUserHeader(double kStatusBarHeight) {
    final avator =
        "https://i2.hdslb.com/bfs/face/d19a34d4f2081baed11d575a516487763605b374.jpg@150w_150h.jpg";

    return Container(
      padding: EdgeInsets.fromLTRB(
        30.0,
        kToolbarHeight + kStatusBarHeight + 20.0,
        20.0,
        30.0,
      ),
      decoration: BoxDecoration(color: Colors.white),
      child: SizedBox(
        height: 80.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              width: 80.0,
              height: 80.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(avator),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(width: 20.0),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "今天又懒得加班",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "微信号:LB8045",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14.0,
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.photo,
                            size: 22.0,
                            color: Colors.black54,
                          ),
                          SizedBox(width: 10.0),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 20.0,
                            color: Colors.black54,
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
