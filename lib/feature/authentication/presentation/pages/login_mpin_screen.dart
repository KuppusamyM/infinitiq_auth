import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:infinitiq_auth/core/utils/pages_path.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:resize/resize.dart';

import '../../../../core/base/widgets/base_scaffold.dart';
import '../../../../core/localization/appresource.dart';
import '../../../../core/res/style/app_theme.dart';
import '../../../../core/utils/app_helpers.dart';
import '../../../../core/widgets/info_dialog.dart';
import '../getx/login_mpin_controller.dart';

class MPinLogin extends StatefulWidget {
  const MPinLogin({Key? key}) : super(key: key);

  @override
  State<MPinLogin> createState() => _MPinLoginScreenState();
}

class _MPinLoginScreenState extends State<MPinLogin> {
  String mPin = '';

  final AppTheme _appTheme = Get.find();
  final LoginMpinController _controller = Get.find();
  final AppResource resource = Get.find();
  final AuthPageNavigator _pageNavigator = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        id: 'parent',
        init: _controller,
        builder: (loginMPinController) {
          return ScreenScaffold(
            resizeToAvoidBottomInset: false,
            backGroundColor: AppHelpers.isTablet()
                ? resource.getColor().tabletScaffoldBackgroundColor
                : null,
            controller: _controller,
            body: AppHelpers.isTablet()
                ? Stack(children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).padding.top + 20.h),
                      child: SizedBox(
                        width: 100.vw,
                        height: 24,
                        child: Center(
                          child: Text(
                            'Log In',
                            style: _appTheme.bold600(17, color: Colors.white),
                          ),
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
                        child: getContent(),
                      ),
                    )
                  ])
                : Column(
                    children: [
                      SizedBox(
                        width: 375.w,
                        child: getContent(),
                      ),
                    ],
                  ),
          );
        });
  }

  Widget getContent() {
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
              child: Center(
                child: Text(
                  'LOG IN',
                  style: _appTheme.bold600(24),
                ),
              ),
            ),
          SizedBox(
            height: AppHelpers.isTablet() ? 76.h : 54.h,
          ),
          //mpin header text
          Text('Log In', style: _appTheme.bold600(24)),
          SizedBox(height: AppHelpers.isTablet() ? 8.h : 20.h),
          Text('Enter your unique MPIN to', style: _appTheme.normal400(12)),
          SizedBox(
            height: 5.h,
          ),
          Text('continue', style: _appTheme.normal400(12)),
          SizedBox(height: AppHelpers.isTablet() ? 51.h : 43.h),
          //mpin text field
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppHelpers.isTablet() ? 106.28.w : 75.w),
            child: PinCodeTextField(
              autoFocus: true,
              appContext: context,
              length: 4,
              showCursor: false,
              onChanged: (val){
                mPin = val;
                if(val.length == 4){
                  _controller.enableButton.value = true;
                  _controller.update();
                }
                else if(val.length != 4 && _controller.enableButton.value){
                  _controller.enableButton.value = false;
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
                  selectedColor: resource.getColor().textBoxFocusedBorder,
                  borderWidth: 1
              ),
            ),
          ),
          Obx(() => SizedBox(height: _controller.showMPinError.value ? 10.h : 0)),
          Obx((){
            if (_controller.showMPinError.value) {
              return Text(
              'Incorrect MPIN, Try again',
              style: _appTheme.errorTextStyle(12),
            );
            }
            return const SizedBox();
          }),
          SizedBox(height: 43.h),
          //forgot MPin button / start again
          TextButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (builder) => Center(
                      child: alertDialog(
                          'Forgot MPIN',
                          'Kindly proceed with sign in to reset your MPIN',
                          'No',
                          'Yes', () {
                        Get.back();
                      }, () {
                        _pageNavigator.offAllNamed(_pageNavigator.signIn);
                      }, context),
                    ));
              },
              child: const Text('Forgot MPIN?')),
          SizedBox(height: 24.h),
          //continue button
          SizedBox(
              height: 56.h,
              width: 343.w,
              child: Obx(() => ElevatedButton(
                  onPressed: _controller.enableButton.value
                      ? () => _controller.loginWithPin(mPin)
                      : null,
                  child: const Text('Log In')))),
          SizedBox(height: 60.h),
        ],
      ),
    );
  }
}
