import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
//import 'package:image_picker_web/image_picker_web.dart';
import 'package:package_info/package_info.dart';
import 'package:uuid/uuid.dart';

/// 判断环境
final isProd = const bool.fromEnvironment('dart.vm.product');

Future<PackageInfo> getPackageInfo() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

//  String appName = packageInfo.appName;
//  String packageName = packageInfo.packageName;
//  String version = packageInfo.version;
//  String buildNumber = packageInfo.buildNumber;
  return packageInfo;
}

///  生成uuid
Uuid uuid = Uuid();

/// 拍照api
class CameraUtil {
  static Future<File> takePhoto({maxWidth, maxHeight, quality}) {
    return ImagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        imageQuality: quality);
  }

  static Future<File> pickPhoto({maxWidth, maxHeight, quality}) {
    if (Platform.isWindows) {
//      return ImagePickerWeb.getImage(outputType: ImageType.file);
    }
    return ImagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        imageQuality: quality);
  }

  static Future<File> takeVideo({maxDuration = const Duration(seconds: 15)}) {
    return ImagePicker.pickVideo(
      source: ImageSource.camera,
      maxDuration: maxDuration,
    );
  }

  static Future<File> pickVideo({maxDuration}) {
    if (Platform.isWindows) {
//      return ImagePickerWeb.getVideo(outputType: VideoType.file);
    }
    return ImagePicker.pickVideo(
      source: ImageSource.gallery,
      maxDuration: maxDuration,
    );
  }
}

/// actionSheet
class BottomActionItem {
  String title;
  GestureTapCallback onTap;

  BottomActionItem({
    this.title,
    this.onTap,
  });
}

void showActionSheet(
  BuildContext context, {
  List<BottomActionItem> actions = const [],
}) {
  List<Widget> children = ListTile.divideTiles(
    tiles: actions.map(
      (action) {
        return ListTile(
          title: Center(child: Text(action.title)),
          onTap: () {
            action.onTap();
            Navigator.of(context).pop();
          },
        );
      },
    ),
    context: context,
  ).toList().cast<Widget>()
    ..addAll([
      Container(
        height: 10.0,
        color: Colors.black38,
      ),
      ListTile(
        title: const Center(child: Text("取消")),
        onTap: () {
          Navigator.of(context).pop();
        },
      ),
    ]);

  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12.0),
        topRight: Radius.circular(12.0),
      ),
    ),
    builder: (BuildContext context) {
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min, // 设置最小的弹出
          children: children,
        ),
      );
    },
  );
}
