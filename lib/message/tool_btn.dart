import 'package:flutter/material.dart';
import 'dart:io';

import '../utils.dart';

Widget galleryBtn(BuildContext context, {onOk: Function}) {
  return BottomChatBtn(
    icon: Icons.photo_library,
    title: "相册",
    onPress: () async {
      showActionSheet(context, actions: [
        BottomActionItem(
          title: "照片",
          onTap: () async {
            File photo = await CameraUtil.pickPhoto();
            onOk(photo, context: context);
          },
        ),
        BottomActionItem(
          title: "视频",
          onTap: () async {
            File video = await CameraUtil.pickVideo();
            onOk(video, context: context);
          },
        ),
      ]);
    },
  );
}

Widget cameraBtn(BuildContext context, {onOk: Function}) {
  return BottomChatBtn(
    icon: Icons.camera_alt,
    title: "拍摄",
    onPress: () async {
      showActionSheet(context, actions: [
        BottomActionItem(
          title: "拍照",
          onTap: () async {
            File photo = await CameraUtil.takePhoto();
            onOk(photo, context: context);
          },
        ),
        BottomActionItem(
          title: "录像",
          onTap: () async {
            File video = await CameraUtil.takeVideo();
            onOk(video, context: context);
          },
        ),
      ]);
    },
  );
}

Widget locationBtn(BuildContext context, {onOk: Function}) {
  return BottomChatBtn(
    icon: Icons.location_on,
    title: "位置",
    onPress: () async {},
  );
}

Widget meBtn(BuildContext context, {onOk: Function}) {
  return BottomChatBtn(
    icon: Icons.person,
    title: "个人名片",
    onPress: () async {},
  );
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
        ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Material(
            color: Colors.white,
            child: Ink(
              width: size * 2,
              height: size * 2,
              child: InkWell(
                onTap: onPress,
                child: Icon(
                  icon,
                  size: size,
                ),
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
