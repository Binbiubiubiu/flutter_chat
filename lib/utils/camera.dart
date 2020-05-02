import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class CameraUtil {
  static Future<File> takePhoto(BuildContext context,
      {maxWidth, maxHeight, quality}) {
    return ImagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        imageQuality: quality);
  }

  static Future<File> pickPhoto(BuildContext context,
      {maxWidth, maxHeight, quality}) {
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
    return ImagePicker.pickVideo(
      source: ImageSource.camera,
      maxDuration: maxDuration,
    );
  }
}
