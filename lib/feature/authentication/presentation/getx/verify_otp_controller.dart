import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinitiq_auth/core/utils/pages_path.dart';


import '../../../../core/base/controller/base_controller.dart';
import '../../../../core/network/error.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/info_dialog.dart';
import '../../domain/usecase/generate_otp_usecase.dart';
import '../../domain/usecase/verify_otp_usecase.dart';

class VerifyOtpController extends GetxController with BaseController {
  bool showOtpError = false, enableButton = false;

  final VerifyOtpUseCase _verifyOtpUseCase;
  final GenerateOtpUseCase _generateOtpUseCase;
  final AuthPageNavigator _pageNavigator;
  RxBool showApiError = false.obs;
  Timer? timer;
  var userId = Get.arguments[0] ?? "";
  var mobileNumber = Get.arguments[1] ?? "";

  VerifyOtpController(
      this._verifyOtpUseCase, this._generateOtpUseCase, this._pageNavigator);

  RxString resendText = "".obs;
  int time = 60;

  Future<void> verifyOtp(String otp, String userId, String phoneNumber) async {
    showApiError.value = false;
    var data = await _verifyOtpUseCase.call(userId, phoneNumber, otp);

    if (data.isLeft()) {
      if(data.getLeft().errorCode == BadRequest().errorCode){
        showApiError.value = true;
      }else{
        showError(data.getLeft().error);
      }
    } else {
      _pageNavigator.offAllNamed(_pageNavigator.setMPin);
    }
  }

  @override
  void onReady() {
    super.onReady();
    timer = Timer.periodic(
        const Duration(seconds: 1), (Timer t) => calculateResetOtp());
  }

  void calculateResetOtp() {
    if (time == 0) {
      resendText.value = "Resend OTP";
    } else {
      time = time - 1;
      resendText.value = "Resend OTP in ${getFormattedString(time, 2, "0")} secs";
    }
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  void resendOtp() async {
    time = 60;

    var data =
        await _generateOtpUseCase.call(userId, mobileNumber);

    if (data.isLeft()) {
      showError(data.getLeft().error);
    } else {
      if (buildContext != null) {
        /*showDialog(context: buildContext!, builder: (builder) =>
            Center(
              child: infoDialog(
                  'OTP sent successfully',
                  'Okay',
                  buildContext!
              ),
            ));*/
      }
    }
  }
}
