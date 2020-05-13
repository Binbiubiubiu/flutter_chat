import 'package:flutter/material.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Test",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Emoji Picker Test"),
        ),
        body: MainPage(),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  MainPageState createState() => new MainPageState();
}

class MainPageState extends State<MainPage> {
  TextEditingController _editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          controller: _editingController,
        ),
      ],
    );
  }
}
