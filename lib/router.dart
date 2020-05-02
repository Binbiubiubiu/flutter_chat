import 'package:flutter/material.dart';
import 'package:simonchat/pages/message.dart';
import 'package:simonchat/tabs/chat.dart';

class SimonRouter {
  static String initialRoute = "/";

  static Map<String, WidgetBuilder> routes = {
    "/": (ctx) => MessagePage(),
    "/login": (ctx) => ChatPage(),
  };

  static Future goToCameraPage(BuildContext context) {
    return Navigator.of(context).pushNamed('/camera');
  }
}
