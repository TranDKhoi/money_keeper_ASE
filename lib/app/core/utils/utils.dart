import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class ConfigHelper {
  static void configLoadingBar() {
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.ring
      ..loadingStyle = EasyLoadingStyle.custom
      ..backgroundColor = Colors.white
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..indicatorColor = Colors.green
      ..userInteractions = true
      ..dismissOnTap = false
      ..textColor = Colors.black
      ..toastPosition = EasyLoadingToastPosition.bottom
      ..displayDuration = const Duration(seconds: 5);
  }
}

extension GetSize on BuildContext {
  Size get screenSize => MediaQuery.of(this).size;
}

extension ApiResponseHandler on Response {
  get data => body["data"];

  String get errorMessage {
    try {
      Map<String, dynamic> map = jsonDecode(bodyString!);
      if (map.keys.contains("message") && body["message"] != null) {
        return body["message"];
      }
      var temp = Map.from(map["errors"]);
      for (var element in temp.values) {
        return element[0];
      }
    } catch (e) {
      print("parse error error: $e");
    }
    return "Server error";
  }
}

class ImageHelper {
  ImageHelper._();

  static final ins = ImageHelper._();
  final _imgPicker = ImagePicker();

  Future<String?> pickAvatar() async {
    final XFile? selected =
        await _imgPicker.pickImage(source: ImageSource.gallery);

    if (selected != null) {
      return await cropImage(selected.path);
    }
    return null;
  }

  Future<List<String>?> pickMultiImage() async {
    final List<XFile>? selected = await _imgPicker.pickMultiImage();

    if (selected != null) {
      return selected.map((e) => e.path).toList();
    }
    return null;
  }

  Future<String?> pickSingleImage() async {
    final XFile? selected =
        await _imgPicker.pickImage(source: ImageSource.gallery);

    if (selected != null) {
      return selected.path;
    }
    return null;
  }

  Future<String?> takePictureFromCamera() async {
    final XFile? selected =
        await _imgPicker.pickImage(source: ImageSource.camera);

    if (selected != null) {
      return selected.path;
    }
    return null;
  }

  Future<String?> cropImage(String path) async {
    CroppedFile? cropped = await ImageCropper()
        .cropImage(sourcePath: path, cropStyle: CropStyle.circle);

    if (cropped != null) {
      return cropped.path;
    }
    return null;
  }
}

class FormatHelper {
  String dateFormat(DateTime date) {
    String formatTime = "${date.day}-${date.month}-${date.year}";
    return formatTime;
  }

  String moneyFormat(double? money) {
    if (money == null) {
      return NumberFormat.simpleCurrency(
        locale: 'vi',
      ).format(0);
    }

    return NumberFormat.simpleCurrency(
      locale: 'vi',
    ).format(money);
  }

  String? getTimeAgo(DateTime? time) {
    if (time == null) {
      return null;
    }
    timeago.setLocaleMessages("vi", timeago.ViMessages());
    return timeago.format(
        time.add(DateTime.parse(time.toString()).timeZoneOffset),
        locale: Get.locale?.languageCode ?? "en");
  }
}
