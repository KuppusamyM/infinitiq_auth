import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../localization/appresource.dart';
import '../color/color.dart';

final AppResource resource = Get.find();
final AppColor colors = resource.getColor();

abstract class AppTheme {

  ThemeData get getAppTheme;

  TextStyle bold600(double fontSize, {Color? color, double? height});

  TextStyle bold700(double fontSize, {Color? color, double? height});

  TextStyle normal500(double fontSize, {Color? color, double? height});

  TextStyle normal400(double fontSize, {Color? color, double? height});

  TextStyle errorTextStyle(double fontSize, {Color? color});

  TextStyle textFieldHintStyle({Color? color});

  InputDecoration underLineTextFieldDecoration(String hintText);

  InputDecoration textFieldDecoration(String hintText);

  InputDecoration searchFieldDecoration(String hintText, {Color? color});

  BoxDecoration get textFieldBorder;

  BoxDecoration get textFieldFocussedBorder;

  BoxDecoration corneredBoxDeco(Color color,{double? radius});

}
