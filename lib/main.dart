import 'package:flutter/material.dart';
import 'package:simonchat/router.dart';
import 'package:simonchat/style.dart' show appTheme;

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simon Chat',
      theme: appTheme,
//      home: LayoutPage(),
      initialRoute: SimonRouter.initialRoute,
      routes: SimonRouter.routes,
    );
  }
}
