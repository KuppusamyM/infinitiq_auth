import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:resize/resize.dart';

import '../../../../core/base/widgets/base_scaffold.dart';
import '../../../../core/localization/appresource.dart';
import '../../../../core/res/images/app_image.dart';
import '../../../../core/res/style/app_theme.dart';
import '../../../../core/utils/app_helpers.dart';
import '../getx/verify_otp_controller.dart';

class OtpScreen extends StatelessWidget {
  final VerifyOtpController _controller = Get.find();
  final AppTheme _appTheme = Get.find();
  final AppResource resource = Get.find();
  String otp = '';

  OtpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        id: 'parent',
        init: _controller,
        builder: (contextt) {
          return ScreenScaffold(
            backGroundColor: AppHelpers.isTablet()
                ? resource.getColor().tabletScaffoldBackgroundColor
                : null,
            controller: _controller,
            resizeToAvoidBottomInset: false,
            body: AppHelpers.isTablet()
                ? Stack(children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).padding.top + 20.h),
                      child: SizedBox(
                        width: 100.vw,
                        height: 24,
                        child: Stack(
                          children: [
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 16.w),
                                  child: InkWell(
                                      onTap: () => Get.back(),
                                      child: const Icon(
                                        Icons.arrow_back_ios,
                                        size: 20,
                                        color: Colors.white,
                                      )),
                                )),
                            Center(
                              child: Text(
                                'OTP',
                                style:
                                    _appTheme.bold600(17, color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 153.h),
                      child: Image.asset(
                        resource.getImages().tabAuthenticationIllustrator,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Center(
                      child: Container(
                        width: 437.w,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: const [
                              BoxShadow(
                                  blurRadius: 56,
                                  spreadRadius: -11,
                                  color: Color.fromRGBO(0, 0, 0, 0.07))
                            ]),
                        child: getContent(context),
                      ),
                    )
                  ])
                : Column(
                    children: [
                      SizedBox(
                        width: 375.w,
                        child: getContent(context),
                      ),
                      /*Expanded(
                        //key: imageWidgetKey,
                        child: Stack(
                          children: [
                            Positioned(
                              child: Image.asset(
                                resource.getImages().illustrator,
                                width: 360.w,
                                height: 334.h,
                                fit: BoxFit.cover,
                              ),
                            )
                          ],
                        ),
                      ),*/
                    ],
                  ),
          );
        });
  }

  Widget getContent(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: AppHelpers.isTablet()
            ? MainAxisAlignment.start
            : MainAxisAlignment.center,
        children: [
          //app bar
          if (!AppHelpers.isTablet())
            SizedBox(height: MediaQuery.of(context).padding.top + 20.h),
          if (!AppHelpers.isTablet())
            SizedBox(
              width: 100.vw,
              height: 24,
              child: Stack(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 16.w),
                        child: InkWell(
                            onTap: () => Get.back(),
                            child: const Icon(
                              Icons.arrow_back_ios,
                              size: 20,
                            )),
                      )),
                  Center(
                    child: Text(
                      'OTP',
                      style: _appTheme.bold600(17),
                    ),
                  )
                ],
              ),
            ),
          SizedBox(
            height: AppHelpers.isTablet() ? 76.h : 54.h,
          ),
          //otp header text
          Text('Enter Verification code',
              style: _appTheme.bold600(AppHelpers.isTablet() ? 20 : 24)),
          SizedBox(height: AppHelpers.isTablet() ? 8.h : 20.h),
          //mobile number text
          Obx(() => Visibility(
                visible: _controller.showApiError.value,
                child: Text('Incorrect OTP, try again',
                    style: _appTheme.errorTextStyle(14)),
              )),
          Obx(() => Visibility(
                visible: !_controller.showApiError.value,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('We\'ve sent an OTP to phone number',
                        style: _appTheme.normal400(12)),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(_controller.mobileNumber.toString(),
                        style: _appTheme.bold600(12))
                  ],
                ),
              )),
          SizedBox(height: 40.h),
          GetBuilder<VerifyOtpController>(
              init: _controller,
              builder: (getController) => Column(
                    children: [
                      //otp text field
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppHelpers.isTablet() ? 42.78.w : 16.w),
                        child: PinCodeTextField(
                          autoFocus: true,
                          appContext: context,
                          length: 6,
                          showCursor: false,
                          onChanged: (val) {
                            otp = val;
                            if(val.length == 6){
                              _controller.enableButton = true;
                              _controller.update();
                            }
                            else if(val.length != 6 && _controller.enableButton){
                              _controller.enableButton = false;
                              _controller.update();
                            }
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.number,
                          obscureText: true,
                          obscuringCharacter: '*',
                          pinTheme: PinTheme(
                              fieldWidth: 48.w,
                              fieldHeight: 52.h,
                              borderRadius: BorderRadius.circular(12),
                              shape: PinCodeFieldShape.box,
                              activeColor: resource.getColor().textBoxBorder,
                              inactiveColor: resource.getColor().textBoxBorder,
                              selectedColor:
                                  resource.getColor().textBoxFocusedBorder,
                              borderWidth: 1),
                        ),
                      ),
                      if (_controller.showOtpError) SizedBox(height: 10.h),
                      if (_controller.showOtpError)
                        Text(
                          'Wrong OTP, please check and enter again',
                          style: _appTheme.errorTextStyle(12),
                        ),
                      SizedBox(height: 40.h),
                      //resend otp
                      TextButton(
                          onPressed: () {
                            if (_controller.time == 0) {
                              _controller.resendOtp();
                            }
                          },
                          child: Obx(
                            () => Text(
                              _controller.resendText.value,
                              style: TextStyle(
                                  color: _controller.time == 0
                                      ? resource.getColor().textButtonColor
                                      : resource
                                          .getColor()
                                          .disableResendOtpColor),
                            ),
                          )),
                      SizedBox(height: 20.h),
                      //continue button
                      SizedBox(
                          height: 56.h,
                          width: 343.w,
                          child: ElevatedButton(
                              onPressed: _controller.enableButton
                                  ? () {
                                      _controller.verifyOtp(
                                          otp,
                                          _controller.userId,
                                          _controller.mobileNumber);
                                    }
                                  : null,
                              child: const Text('Continue'))),
                      SizedBox(
                        height: 70.h,
                      )
                    ],
                  )),
        ],
      ),
    );
  }
}
