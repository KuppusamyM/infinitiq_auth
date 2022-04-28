import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinitiq_auth/core/utils/pages_path.dart';

import '../../../../core/base/controller/base_controller.dart';
import '../../../../core/network/error.dart';
import '../../domain/usecase/generate_otp_usecase.dart';

class SignInController extends GetxController with BaseController {
  final GenerateOtpUseCase _generateOtpUseCase;
  final AuthPageNavigator _navigator;
  String? userId, mobile;

  FocusNode userIdFocusNode = FocusNode();
  FocusNode mobileNumberFocusNode = FocusNode();
  bool showUserIdError = false, showMobileNumberError = false;
  bool showApiError = false;
  RxBool enableButton = false.obs;

  SignInController(this._generateOtpUseCase, this._navigator);

  Future<void> generateOtp(String? id, String? phoneNumber) async {
    showApiError = false;
    update(['parent']);

    var data = await _generateOtpUseCase.call(id ?? "", phoneNumber ?? "");

    if (data.isLeft()) {
      if (data.getLeft().errorCode == BadRequest().errorCode) {
        showApiError = true;
        update(['parent']);
      } else {
        showError(data.getLeft().error);
      }
    } else {
      userId = null;
      mobile = null;
      _navigator.navigateTo(_navigator.otp, arguments: [id, phoneNumber]);
    }
  }

}
