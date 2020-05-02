import 'dart:ui';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simonchat/generated/json/message_entity_helper.dart';
import 'package:simonchat/mock/message.dart';
import 'package:simonchat/models/message_entity.dart';
import 'package:simonchat/style.dart' as appTheme;
import 'package:simonchat/utils/camera.dart';
import 'package:simonchat/widgets/message_container.dart';
import 'package:uuid/uuid.dart';

class MessagePage extends StatefulWidget {
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  List<MessageEntity> msgList = messageMock.map((item) {
    return messageEntityFromJson(MessageEntity(), item);
  }).toList();

  @override
  Widget build(BuildContext context) {
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      appBar: AppBar(
        title: Text("IT摸鱼校尉(99)"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_horiz),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: msgList.map((msg) {
                return Message(
                  key: ValueKey(msg.id),
                  avator: msg.user.avator,
                  child: msg.content is String
                      ? Text(
                          msg.content,
                          style: msgTextStyle,
                        )
                      : msg.content,
                  isMe: msg.user.name == "张三",
                );
              }).toList(),
            ),
          ),
          BottomChatField(
            keyboardHeight: keyboardHeight,
            onSubmit: (content) {
              print(content is String);
              if (content is String) {
                setState(() {
                  MessageEntity msg = messageEntityFromJson(MessageEntity(), {
                    "id": Uuid(),
                    "type": "text",
                    "user": {
                      "avator":
                          "https://dss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2104351895,3299575660&fm=26&gp=0.jpg",
                      "name": "张三",
                    },
                    "content": content
                  });
                  msgList.add(msg);
                  print(msgList);
                });
              }

              if (content is File) {
                setState(() {
                  MessageEntity msg = messageEntityFromJson(MessageEntity(), {
                    "id": Uuid(),
                    "type": "text",
                    "user": {
                      "avator":
                          "https://dss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2104351895,3299575660&fm=26&gp=0.jpg",
                      "name": "张三",
                    },
                    "content": content
                  });
                  msg.content = ConstrainedBox(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * .6),
                      child: Image.file(
                        content,
                        fit: BoxFit.cover,
                      ));
                  msgList.add(msg);
                  print(msgList);
                });
              }
            },
          ),
        ],
      ),
    );
  }
}

final msgTextStyle = TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.w500,
);

enum MessageType { text, img }

class Message extends StatelessWidget {
  final isMe;
  final String avator;
  final MessageType type;
  final Widget child;

  Message({
    Key key,
    this.avator,
    this.type = MessageType.text,
    this.isMe = false,
    this.child,
  })  : assert(avator != null),
        assert(type != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return isMe ? _meSend(context) : _otherSend(context);
  }

  Widget _otherSend(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Row(
        children: <Widget>[
          _avator(context),
          const SizedBox(width: 20.0),
          MessageContainer(
            child: child,
          ),
        ],
      ),
    );
  }

  Widget _meSend(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          MessageContainer(
            color: appTheme.secondary,
            arrow: MessageArrowDirect.right,
            child: child,
          ),
          const SizedBox(width: 20.0),
          _avator(context),
        ],
      ),
    );
  }

  Widget _avator(BuildContext context) {
    const _avatorSize = 48.0;
    return ClipRRect(
      borderRadius: BorderRadius.circular(6.0),
      child: Image.network(
        this.avator,
        width: _avatorSize,
        height: _avatorSize,
        fit: BoxFit.cover,
      ),
    );
  }
}

class BottomChatField extends StatefulWidget {
  final double keyboardHeight;
  final ValueChanged onSubmit;

  BottomChatField({
    Key key,
    this.keyboardHeight,
    this.onSubmit,
  })  : assert(onSubmit != null),
        super(key: key);
  @override
  _BottomChatFieldState createState() => _BottomChatFieldState();
}

class _BottomChatFieldState extends State<BottomChatField> {
  TextEditingController _inputController;
  FocusNode _inputFocus;

  double _keyboardHeight = 0;
  bool _toolMenuShow = false;

  @override
  void initState() {
    _inputController = TextEditingController();
    _inputController.addListener(() {
      print('input ${_inputController.text}');
    });

    _inputFocus = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _inputController?.dispose();

    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(BottomChatField oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (widget.keyboardHeight != 0) {
      this.setState(() {
        _toolMenuShow = false;
      });
    }

    if (_keyboardHeight < widget.keyboardHeight) {
      this.setState(() {
        _keyboardHeight = widget.keyboardHeight;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFF7F7F7),
        ),
        child: Column(
          children: <Widget>[
            Container(
              height: kToolbarHeight,
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(true ? Icons.keyboard_voice : Icons.keyboard),
                    onPressed: () {},
                  ),
                  Expanded(
                    child: _bottomInput(context),
                  ),
                  IconButton(
                    icon: Icon(Icons.tag_faces),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.control_point),
                    onPressed: () {
                      _inputFocus.unfocus();
                      setState(() {
                        _toolMenuShow = !_toolMenuShow;
                      });
                    },
                  ),
                ],
              ),
            ),
            Divider(height: 0.0),
            Visibility(
              visible: _toolMenuShow,
              child: Container(
                height: _keyboardHeight,
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: SwingView(
                        children: <Widget>[
                          StaticGridView(
                            width: 190.0 * 2,
                            height: 190.0,
                            children: [
                              _cameraBtn(context),
                              _galleryBtn(context),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _bottomInput(BuildContext context) {
    InputDecoration inputStyle = InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: Color(0xffffffff),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
    );

    return TextField(
      focusNode: _inputFocus,
      controller: _inputController,
      style: TextStyle(
        textBaseline: TextBaseline.alphabetic,
        height: 1.4,
      ),
      onSubmitted: (msg) {
        widget.onSubmit(msg);
      },
      decoration: inputStyle,
      autofocus: _keyboardHeight == 0,
    );
  }

  _cameraBtn(BuildContext context) {
    return BottomChatBtn(
      icon: Icons.camera_alt,
      title: "拍摄",
      onPress: () async {
        File photo = await CameraUtil.takePhoto(context);
        widget.onSubmit(photo);
      },
    );
  }

  _galleryBtn(BuildContext context) {
    return BottomChatBtn(
      icon: Icons.photo_library,
      title: "相册",
      onPress: () async {
        File photo = await CameraUtil.pickPhoto(context);
        widget.onSubmit(photo);
      },
    );
  }
}

class BottomChatBtn extends StatelessWidget {
  final double size;
  final IconData icon;
  final String title;
  final GestureTapCallback onPress;

  BottomChatBtn({
    Key key,
    this.size = 32.0,
    this.icon,
    this.title = "",
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Material(
          child: Ink(
            width: size * 2,
            height: size * 2,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
            child: InkWell(
              onTap: onPress,
              child: Icon(
                icon,
                size: size,
              ),
            ),
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          title,
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.black54,
          ),
        )
      ],
    );
  }
}

class SwingView extends StatefulWidget {
  final double height;
  final List<Widget> children;

  SwingView({
    Key key,
    this.height = 286.0,
    this.children,
  }) : super(key: key);

  @override
  _SwingViewState createState() => _SwingViewState();
}

class _SwingViewState extends State<SwingView> {
  int _activeIdx;

  @override
  void initState() {
    _activeIdx = 0;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> spots = widget.children
        .asMap()
        .keys
        .map((f) => buildSpot(isActive: f == _activeIdx))
        .toList();

    return Container(
      height: widget.height,
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          Expanded(
            child: PageView(
              onPageChanged: (i) {
                setState(() {
                  _activeIdx = i;
                });
              },
              children: widget.children,
            ),
          ),
          Container(
            height: 40.0,
            alignment: Alignment.topCenter,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: spots,
            ),
          )
        ],
      ),
    );
  }

  Widget buildSpot({isActive: false}) {
    return Container(
      width: 8.0,
      height: 8.0,
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        color: isActive ? Colors.black54 : Colors.black12,
        borderRadius: BorderRadius.circular(6.0),
      ),
    );
  }
}

class StaticGridView extends StatelessWidget {
  final List<Widget> children;
  final double width;
  final double height;

  StaticGridView({
    Key key,
    this.width,
    this.height,
    this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: width,
        height: height,
        child: GridView.count(
          physics: ClampingScrollPhysics(),
          crossAxisCount: 4,
          primary: true,
          children: children,
        ),
      ),
    );
  }
}
