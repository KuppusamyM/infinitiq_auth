import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_helpers.dart';

class AuthPageNavigator {
  final String splash = "/";
  final String signIn = "/signIn";
  final String otp = "/otp";
  final String setMPin = "/setMPin";
  final String pinLogin = "/pinLogin";
  final String landingScreenMobile = '/landingScreenMobile';
  final String landingScreenTablet = '/landingScreenTablet';


  void navigateTo(String name, {dynamic arguments, int? id}) {
    Get.toNamed(name, arguments: arguments, id: id);
  }

  void offAllNamed(String name, {dynamic arguments, int? id}) {
    Get.offAllNamed(name, arguments: arguments, id: id);
  }

  void navigateBack({int? id}) {
    Get.back(id: id);
  }

}
