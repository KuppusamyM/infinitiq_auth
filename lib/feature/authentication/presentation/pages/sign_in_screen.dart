import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:resize/resize.dart';

import '../../../../core/base/widgets/base_scaffold.dart';
import '../../../../core/localization/appresource.dart';
import '../../../../core/res/style/app_theme.dart';
import '../../../../core/utils/app_helpers.dart';
import '../../../../core/widgets/info_dialog.dart';
import '../getx/sign_in_controller.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);

  final AppResource resource = Get.find();
  final AppTheme _appTheme = Get.find();
  final SignInController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      backGroundColor: AppHelpers.isTablet() ? resource.getColor().tabletScaffoldBackgroundColor : null,
      resizeToAvoidBottomInset: false,
      controller: _controller,
      body: AppHelpers.isTablet()
          ? Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 153.h),
            child: Image.asset(resource.getImages().tabAuthenticationIllustrator, fit: BoxFit.fitWidth,),
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
                        color: Color.fromRGBO(0, 0, 0, 0.07)
                    )
                  ]
              ),
              child: getContent(context),
            ),
          )
        ],
      )
          : Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).padding.top,
                ),
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
  }

  Widget getContent(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: AppHelpers.isTablet() ? MainAxisAlignment.start : MainAxisAlignment.center,
        children: [
          //logo
          SizedBox(height: 45.h,),
          Image.asset(
            resource.getImages().logo,
            width: 82.88.w,
            height: 61.36.h,
          ),
          SizedBox(height: AppHelpers.isTablet() ? 20.47.h : 20.h),
          //sign in header text
          Text('Let\'s sign you in',
              style: _appTheme.bold600(AppHelpers.isTablet() ? 20 : 24)),
          SizedBox(height: AppHelpers.isTablet() ? 45.17.h : 16.h),
          GetBuilder(
              init: _controller,
              id: 'parent',
              builder: (controller) {
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Visibility(
                        visible: _controller.showApiError,
                        child: Text(
                            "Login details doesn’t match, please check & try again",
                            style: _appTheme
                                .errorTextStyle(AppHelpers.isTablet() ? 20 : 13)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Visibility(
                          visible: _controller.showApiError,
                          child: SizedBox(height: 20.h)),
                    ),
                    //user id text field
                    Container(
                      width: 343.w,
                      padding: EdgeInsets.symmetric(vertical: 4.h , horizontal: 5.w),
                      decoration: _controller.userIdFocusNode.hasFocus
                          ? _appTheme.textFieldFocussedBorder
                          : _appTheme.textFieldBorder,
                      child: Center(
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9A-Z-]')),
                            LengthLimitingTextInputFormatter(13),
                          ],
                          focusNode: _controller.userIdFocusNode,
                          onTap: () {
                            _controller.showUserIdError = false;
                            if (_controller.mobile != null && _controller.mobile!.length != 10) {
                              _controller.showMobileNumberError = true;
                            } else {
                              _controller.showMobileNumberError = false;
                            }
                            _controller.update(['parent']);
                          },
                          onChanged: (val) {
                            _controller.userId = val;
                            if (_controller.userId != null &&
                                _controller.userId!.length >= 11 &&
                                _controller.mobile != null &&
                                _controller.mobile!.length == 10) {
                              _controller.enableButton.value = true;
                            } else if (_controller.enableButton.value) {
                              _controller.enableButton.value = false;
                            }
                            if(val.length >= 11)
                            {
                              _controller.showUserIdError = false;
                            }
                            else{
                              _controller.showUserIdError = true;
                            }
                            _controller.update();
                          },
                          style: _appTheme.bold600(15),
                          onFieldSubmitted: (val) => _controller.update(['parent']),
                          decoration: _appTheme.underLineTextFieldDecoration('Enter User Id'),
                        ),
                      ),
                    ),

                    if (_controller.showUserIdError) SizedBox(height: 10.h),
                    if (_controller.showUserIdError) SizedBox(
                        width: 325.w,
                        child: Text('UID is not complete',
                            style: _appTheme.errorTextStyle(12))),

                    SizedBox(height: AppHelpers.isTablet() ? 16.h : 20.h),
                    //_controller.mobile number text field
                    Container(
                      width: 343.w,
                      padding: EdgeInsets.symmetric(vertical: 4.h , horizontal: 5.w),
                      decoration: _controller.mobileNumberFocusNode.hasFocus
                          ? _appTheme.textFieldFocussedBorder
                          : _appTheme.textFieldBorder,
                      child: Center(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          focusNode: _controller.mobileNumberFocusNode,
                          onTap: () {
                            if (_controller.userId == null || _controller.userId!.length <= 11) {
                              _controller.showUserIdError = true;
                            } else {
                              _controller.showUserIdError = false;
                            }
                            _controller.update(['parent']);
                          },
                          onChanged: (val) {
                            _controller.mobile = val;
                            if (_controller.userId != null &&
                                _controller.userId!.length >= 11 &&
                                _controller.mobile != null &&
                                _controller.mobile!.length == 10) {
                              _controller.enableButton.value = true;
                            } else if (_controller.enableButton.value) {
                              _controller.enableButton.value = false;
                            }
                            if(val.length == 10)
                              {
                                _controller.showMobileNumberError = false;
                              }
                            else{
                              _controller.showMobileNumberError = true;
                            }
                            _controller.update();
                          },
                          style: _appTheme.bold600(13),
                          onFieldSubmitted: (val) => _controller.update(['parent']),
                          decoration:
                          _appTheme.underLineTextFieldDecoration('Enter Mobile Number'),
                        ),
                      ),
                    ),
                    if (_controller.showMobileNumberError) SizedBox(height: 10.h),
                    if (_controller.showMobileNumberError)SizedBox(
                        width: 325.w,
                        child: Text('Mobile number is not complete',
                            style: _appTheme.errorTextStyle(12))),
                    //forgot user button
                    SizedBox(
                      width: 343.w,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: () => showDialog(
                                context: context,
                                builder: (builder) => Center(
                                  child: infoDialog(
                                      'Forgot User Id',
                                      'Kindly contact your school admin\n to get user Id',
                                      'Okay',
                                      context),
                                )),
                            child: const Text('Forgot User Id?')),
                      ),
                    ),
                    SizedBox(height: 21.h),
                    //continue button
                    SizedBox(
                        height: 56.h,
                        width: 343.w,
                        child: Obx(
                          () =>  ElevatedButton(
                              onPressed: _controller.enableButton.value
                                  ? () => _controller.generateOtp(_controller.userId, _controller.mobile)
                                  : null,
                              child: const Text('Continue')),
                        )),
                  ],
                );
              }),
          SizedBox(height: AppHelpers.isTablet() ? 56.h : 20.h),
        ],
      ),
    );
  }
}
