import 'dart:ffi';

import 'package:infinitiq_auth/core/utils/shared_preference_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preference {

  Future<SharedPreferences> _getPreference() async {
    return await SharedPreferences.getInstance();
  }

  Future<String?> getRefreshToken() async {
    var preference = await _getPreference();
    await preference.reload();
    return preference.getString(SharedPreferenceConstants.refreshToken);
  }

  Future<bool> setRefreshToken(String? token) async {
    var preference = await _getPreference();
    return await preference.setString(
        SharedPreferenceConstants.refreshToken, token ?? "");
  }

  Future<bool> setUserId(String userId) async{
    var preference = await _getPreference();
    return await preference.setString(
        SharedPreferenceConstants.userId, userId);
  }

  Future<String?> getUserId() async {
    var preference = await _getPreference();
    await preference.reload();
    return preference.getString(SharedPreferenceConstants.userId);
  }

  void setOnBoardingStatus(bool value) => _getPreference().then((pref) => pref.setBool(SharedPreferenceConstants.skipOnBoarding, value));

  Future<bool?> getOnBoardingStatus() async {
    var preference = await _getPreference();
    return preference.getBool(SharedPreferenceConstants.skipOnBoarding);
  }


  Future<bool?> isLogin() async {
    var preference = await _getPreference();
    await preference.reload();
    return preference.getBool(SharedPreferenceConstants.isLogin);
  }

  Future<bool> setLogin(bool? token) async {
    var preference = await _getPreference();
    return await preference.setBool(
        SharedPreferenceConstants.isLogin, token ?? false);
  }
}
