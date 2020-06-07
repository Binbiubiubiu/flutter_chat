import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rongcloud_im_plugin/rongcloud_im_plugin.dart';
import 'package:simonchat/router.dart';
import 'package:simonchat/style.dart' show appTheme;

const RongAppKey = "pwe86ga5p9qj6";
const RongIMToken = "U61IXOthPuOZlL";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  RongIMClient.init(RongAppKey);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    RongIMClient.connect(RongIMToken, (int code, String userId) {
      print('connect result ' + code.toString() + '---' + userId);
//      EventBus.instance.commit(EventKeys.UpdateNotificationQuietStatus, {});
      if (code == 31004 || code == 12) {
//        Navigator.of(context).pushAndRemoveUntil(
//            new MaterialPageRoute(builder: (context) => new LoginPage()),
//            (route) => route == null);
      } else if (code == 0) {
        print("connect userId" + userId);
        // 连接成功后打开数据库
        // _initUserInfoCache();

      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simon Chat',
      theme: appTheme,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('zh', 'CN'),
        const Locale('en', 'US'),
      ],
//      home: LayoutPage(),
      initialRoute: SimonRouter.initialRoute,
      routes: SimonRouter.routes,
    );
  }
}
