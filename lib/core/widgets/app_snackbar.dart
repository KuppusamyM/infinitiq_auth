import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

import '../localization/appresource.dart';
import '../utils/log.dart';

class AppSnackBar {
  final BuildContext? context;
  final String? content;
  final AppResource localization = Get.find();

  AppSnackBar(this.context, this.content);

  void show() {
    if (context == null) {
      Logger.log("Build Context seems to be null");
    } else {
      ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
          content: SizedBox(
            width: double.infinity,
            height: 20.h,
            child: Stack(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(content ?? "",style: const TextStyle(color: Colors.white),)),
              ],
            ),
          ),
          backgroundColor: Colors.black));
    }
  }
}
