import 'package:flutter/material.dart';

import '../style.dart' as appTheme;
import 'message_container.dart';

class Message extends StatelessWidget {
  final isMe;
  final String avator;
  final Widget child;

  Message({
    Key key,
    this.avator,
    this.isMe = false,
    this.child,
  })  : assert(avator != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return isMe ? _meSend() : _otherSend();
  }

  Widget _otherSend() {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Row(
        children: <Widget>[
          _Avator(this.avator),
          const SizedBox(width: 20.0),
          MessageContainer(
            child: child,
          ),
        ],
      ),
    );
  }

  Widget _meSend() {
    return Container(
      alignment: Alignment.topRight,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          MessageContainer(
            color: appTheme.secondary,
            arrow: MessageArrowDirect.right,
            child: child,
          ),
          const SizedBox(width: 20.0),
          _Avator(this.avator),
        ],
      ),
    );
  }
}

class _Avator extends StatelessWidget {
  final String avator;
  final double size;

  _Avator(
    this.avator, {
    Key key,
    this.size = 48.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6.0),
      child: Image.network(
        this.avator,
        width: this.size,
        height: this.size,
        fit: BoxFit.cover,
      ),
    );
  }
}
