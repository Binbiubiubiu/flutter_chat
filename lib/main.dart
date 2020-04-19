import 'package:flutter/material.dart';
import 'package:simonchat/style.dart' show appTheme;
import 'package:simonchat/tabs/chat.dart';

import 'layout.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simon Chat',
      theme: appTheme,
      home: LayoutPage(),
      initialRoute: "/",
      routes: {
        "/login": (ctx) => ChatPage(),
      },
    );
  }
}
