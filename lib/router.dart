import 'package:flutter/material.dart';
import 'package:simonchat/layout.dart';
import 'message/message_page.dart';

class SimonRouter {
  static String initialRoute = "/";

  static Map<String, WidgetBuilder> routes = {
    "/": (ctx) => LayoutPage(),
    "/message": (ctx) => MessagePage(),
  };

  static Future goToMessagePage(BuildContext context) {
    return Navigator.of(context).pushNamed('/camera');
  }
}
