import 'dart:ui';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:simonchat/generated/json/message_entity_helper.dart';
import 'package:simonchat/mock/message.dart';
import 'package:simonchat/models/message_entity.dart';
import 'package:simonchat/utils.dart';
import 'package:simonchat/widgets/emoji_picker.dart';
import 'package:video_player/video_player.dart';

import 'tool_btn.dart';
import 'message.dart';

final _msgTextStyle = TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.w500,
);

class MessagePage extends StatefulWidget {
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  List<MessageEntity> msgList;
  ScrollController _scrollController;
  VideoPlayerController _controller;

  @override
  void initState() {
    _scrollController = ScrollController();
    msgList = messageMock.map((item) {
      return messageEntityFromJson(MessageEntity(), item);
    }).toList();

    super.initState();
  }

  @override
  void deactivate() {
    if (_controller != null) {
      _controller.setVolume(0.0);
      _controller.pause();
    }
    super.deactivate();
  }

  @override
  void dispose() {
    _disposeVideoController();
    _scrollController?.dispose();
    super.dispose();
  }

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
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: msgList.length,
                shrinkWrap: true,
                reverse: true,
                itemBuilder: (BuildContext ctx, int index) {
                  MessageEntity msg = msgList[index];
                  return Message(
                    key: ValueKey(msg.id),
                    avator: msg.user.avator,
                    child: msg.content is String
                        ? Text(
                            msg.content,
                            style: _msgTextStyle,
                          )
                        : msg.content,
                    isMe: msg.user.name == "张三",
                  );
                },
              ),
            ),
            MessageBottomBar(
              keyboardHeight: keyboardHeight,
              onSubmit: _submit,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _disposeVideoController() async {
    if (_controller != null) {
      await _controller.dispose();
      _controller = null;
    }
  }

  Future<void> _playVideo(File file) async {
    if (file != null && mounted) {
      await _disposeVideoController();
      _controller = VideoPlayerController.file(file);
      await _controller.setVolume(1.0);
      await _controller.initialize();
      await _controller.setLooping(true);
      await _controller.play();
      setState(() {});
    }
  }

  _submit(content, {BuildContext context}) {
    if (content is String) {
      setState(() {
        MessageEntity msg = messageEntityFromJson(MessageEntity(), {
          "id": uuid.v1(),
          "type": "text",
          "user": {
            "avator":
                "https://dss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2104351895,3299575660&fm=26&gp=0.jpg",
            "name": "张三",
          },
          "content": content
        });
        msgList.insert(0, msg);
        _scrollController.animateTo(
          0.0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
        );
      });
    }

    if (content is File) {
      _playVideo(content);
      setState(() {
        MessageEntity msg = messageEntityFromJson(MessageEntity(), {
          "id": uuid.v1(),
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
            maxWidth: MediaQuery.of(context).size.width * .6,
          ),
          child: AspectRatioVideo(_controller),
//          child: Image.file(
//            content,
//            fit: BoxFit.cover,
//          ),
        );
        msgList.insert(0, msg);
        _scrollController.animateTo(
          0.0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
        );
      });
    }
  }
}

class MessageBottomBar extends StatefulWidget {
  final double keyboardHeight;
  final Function onSubmit;

  MessageBottomBar({
    Key key,
    this.keyboardHeight,
    this.onSubmit,
  }) : super(key: key);

  @override
  _MessageBottomBarState createState() => _MessageBottomBarState();
}

class _MessageBottomBarState extends State<MessageBottomBar>
    with SingleTickerProviderStateMixin {
  TextEditingController _inputController;
  FocusNode _inputFocus;

  double _keyboardHeight = 200.0;
  String menuType = "";

  String content = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _inputController = TextEditingController();
    _inputController.addListener(() {
      if (mounted) {
        setState(() {
          content = _inputController.text;
        });
      }

//      print('input ${_inputController.text}');
    });

    _inputFocus = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _inputController?.dispose();
    _inputFocus?.dispose();
  }

  @override
  void didUpdateWidget(MessageBottomBar oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

    if (_keyboardHeight < widget.keyboardHeight) {
      this.setState(() {
        _keyboardHeight = widget.keyboardHeight;
      });
    }

    if (widget.keyboardHeight != 0) {
      this.setState(() {
        menuType = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFF7F7F7),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: kToolbarHeight,
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: <Widget>[
                IconButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  icon: Icon(true ? Icons.keyboard_voice : Icons.keyboard),
                  onPressed: () {},
                ),
                Expanded(
                  child: _bottomInput(context),
                ),
                IconButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  icon: Icon(Icons.tag_faces),
                  onPressed: () {
                    setState(() {
                      menuType = menuType == "emoji" ? "" : "emoji";
                      _inputFocus.requestFocus();
                    });
                  },
                ),
                AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  vsync: this,
                  child: Visibility(
                    visible: content.length != 0,
                    replacement: IconButton(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      icon: Icon(Icons.control_point),
                      onPressed: () {
                        _inputFocus.unfocus();
                        setState(() {
                          menuType = menuType == "tool" ? "" : "tool";
                        });
                      },
                    ),
                    child: Container(
                      width: 62.0,
                      margin: EdgeInsets.only(right: 10.0),
                      child: MaterialButton(
                        onPressed: () {
                          widget.onSubmit(content);
                          _inputController.clear();
//                          _inputFocus.unfocus();
                        },
                        textColor: Colors.white,
                        color: Theme.of(context).primaryColor,
                        child: Text("发送"),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 0.0),
          Visibility(
            visible: menuType == "tool",
            child: SizedBox(
              height: _keyboardHeight,
              child: SwingView(
                children: <Widget>[
                  galleryBtn(context, onOk: widget.onSubmit),
                  cameraBtn(context, onOk: widget.onSubmit),
                  locationBtn(context, onOk: widget.onSubmit),
                  meBtn(context, onOk: widget.onSubmit),
                ],
              ),
            ),
          ),
          Visibility(
            visible: menuType == "emoji",
            child: SizedBox(
              height: _keyboardHeight,
              child: EmojiPicker(
                onSelected: (emoji) {
                  _inputController.text += emoji;
                },
                onDelete: () {
                  var sRunes = content.runes;
                  print(sRunes.length);
                  print(content.length);
                  _inputController.text =
                      String.fromCharCodes(sRunes, 0, sRunes.length - 1);
//                  _inputController.text =
//                      content.substring(0, content.length - 1);
                },
                disabledDelete: content.length == 0,
              ),
            ),
          ),
        ],
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
      fillColor: Colors.white,
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
        _inputController.clear();
      },
      decoration: inputStyle,
      cursorColor: Theme.of(context).primaryColor,
//      autofocus: _keyboardHeight == 0,
    );
  }
}

class SwingView extends StatefulWidget {
  final List<Widget> children;

  SwingView({
    Key key,
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
    int total = widget.children.length;
    int pageSize = 8;
    int pageNum = (total / pageSize).ceil();

    List<Widget> pages = List.generate(
      pageNum,
      (i) {
        int start = i * pageSize;
        int end = start + pageSize > total ? total : start + pageSize;
        return _grid(
          widget.children.getRange(start, end).toList(),
        );
      },
    ).toList();

    return Column(
      children: <Widget>[
        Expanded(
          child: PageView(
            onPageChanged: (i) {
              setState(() {
                _activeIdx = i;
              });
            },
            children: pages,
          ),
        ),
        Visibility(
          visible: pageNum > 1,
          replacement: SizedBox(height: _spotsBarHeight),
          child: _spots(pageNum),
        )
      ],
    );
  }

  Widget _grid(List<Widget> children) {
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.only(top: 20.0),
      child: GridView.count(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        crossAxisCount: 4,
        mainAxisSpacing: 20.0,
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        children: children,
      ),
    );
  }

  final double _spotsBarHeight = 40.0;
  final double _spotSize = 8.0;

  Widget _spots(pageNum) {
    List<Widget> spots = List.generate(
      pageNum,
      (f) => Container(
        width: _spotSize,
        height: _spotSize,
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
          color: f == _activeIdx ? Colors.black54 : Colors.black12,
          borderRadius: BorderRadius.circular(6.0),
        ),
      ),
    ).toList();

    return Container(
      height: _spotsBarHeight,
      alignment: Alignment.topCenter,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: spots,
      ),
    );
  }
}

class AspectRatioVideo extends StatefulWidget {
  AspectRatioVideo(this.controller);

  final VideoPlayerController controller;

  @override
  AspectRatioVideoState createState() => AspectRatioVideoState();
}

class AspectRatioVideoState extends State<AspectRatioVideo> {
  VideoPlayerController get controller => widget.controller;
  bool initialized = false;

  void _onVideoControllerUpdate() {
    if (!mounted) {
      return;
    }
    if (initialized != controller.value.initialized) {
      initialized = controller.value.initialized;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(_onVideoControllerUpdate);
  }

  @override
  void dispose() {
    controller.removeListener(_onVideoControllerUpdate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (initialized) {
      return Center(
        child: AspectRatio(
          aspectRatio: controller.value?.aspectRatio,
          child: VideoPlayer(controller),
        ),
      );
    } else {
      return Container();
    }
  }
}
