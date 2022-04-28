

import 'dart:ui';

import '../res/color/color.dart';
import '../res/images/app_image.dart';
import '../res/strings/strings.dart';
import '../res/style/app_theme.dart';



abstract class AppResource{

  AppColor getColor();

  AppStrings getString();

  AppImages getImages();

  AppTheme getTheme();

  List<Locale> getSupportedLocales();

}