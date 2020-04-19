import 'package:flutter/material.dart';

class FindPage extends StatefulWidget {
  @override
  _FindPageState createState() => _FindPageState();
}

class _FindPageState extends State<FindPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        DecoratedBox(
          decoration: BoxDecoration(color: Colors.white),
          child: ListTile(
            onTap: () {},
            leading: Icon(Icons.camera),
            title: Text("朋友圈"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                FlutterLogo(),
                SizedBox(width: 10.0),
                Icon(Icons.arrow_forward_ios)
              ],
            ),
          ),
        ),
        SizedBox(height: 10.0),
        DecoratedBox(
          decoration: BoxDecoration(color: Colors.white),
          child: ListTile(
            onTap: () {},
            leading: Icon(Icons.crop_free),
            title: Text("扫一扫"),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        ),
        Divider(height: 0),
        DecoratedBox(
          decoration: BoxDecoration(color: Colors.white),
          child: ListTile(
            onTap: () {},
            leading: Icon(Icons.phone),
            title: Text("摇一摇"),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        ),
        SizedBox(height: 10.0),
        DecoratedBox(
          decoration: BoxDecoration(color: Colors.white),
          child: ListTile(
            onTap: () {},
            leading: Icon(Icons.looks),
            title: Text("看一看"),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        ),
        Divider(height: 0),
        DecoratedBox(
          decoration: BoxDecoration(color: Colors.white),
          child: ListTile(
            onTap: () {},
            leading: Icon(Icons.crop),
            title: Text("搜一搜"),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        ),
        SizedBox(height: 10.0),
        DecoratedBox(
          decoration: BoxDecoration(color: Colors.white),
          child: ListTile(
            onTap: () {},
            leading: Icon(Icons.people_outline),
            title: Text("附近的人"),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        ),
        SizedBox(height: 10.0)
      ],
    );
  }
}
