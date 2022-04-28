import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:resize/resize.dart';

import '../../../../core/base/widgets/base_scaffold.dart';
import '../../../../core/localization/appresource.dart';
import '../../../../core/res/style/app_theme.dart';
import '../../../../core/utils/app_helpers.dart';
import '../../../../core/widgets/bottom_sheet.dart';
import '../getx/set_mpin_controller.dart';

class SetMPinScreen extends StatefulWidget {
  const SetMPinScreen({Key? key}) : super(key: key);

  @override
  State<SetMPinScreen> createState() => _SetMPinScreenState();
}

class _SetMPinScreenState extends State<SetMPinScreen> {
  bool enableButton = false;
  String pin = "", confirmPin = "", tmpPin = '';

  final AppTheme _appTheme = Get.find();
  final SetMPinController _controller = Get.find();
  final AppResource resource = Get.find();
  final TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
            child: Center(
              child: Text(
                'MPIN',
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
  }

  Widget getContent() => SingleChildScrollView(
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
            child: Center(
              child: Text(
                'MPIN',
                style: _appTheme.bold600(17),
              ),
            ),
          ),
        SizedBox(
          height: AppHelpers.isTablet() ? 76.h : 54.h,
        ),
        //mPin header text
        Obx(() => Text(_controller.isConfirmPin.value == true ? 'Confirm MPin' : 'Set MPIN',
            style: _appTheme.bold600(24))),
        SizedBox(height: AppHelpers.isTablet() ? 8.h : 20.h),
        //mobile number text
        Obx((){
          return _controller.isError.value == true
              ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                images.errorMpin,
                height: 22.h,
                width: 22.w,
              ),
              SizedBox(
                width: 8.w,
              ),
              Text('Incorrect MPIN,try again',
                  style: _appTheme.errorTextStyle(14)),
            ],
          )
              : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  _controller.isConfirmPin.value
                      ? 'Re-enter your MPIN to'
                      : 'Create your unique MPIN to',
                  style: _appTheme.normal400(12)),
              SizedBox(
                height: 5.h,
              ),
              Text('continue', style: _appTheme.normal400(12))
            ],
          );
        }),
        SizedBox(height: AppHelpers.isTablet() ? 40.h : 50.h),
        //otp text field
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppHelpers.isTablet() ? 106.28.w : 75.w),
          child: PinCodeTextField(
            autoFocus: true,
            controller: _textEditingController,
            appContext: context,
            length: 4,
            showCursor: false,
            onChanged: (val) {
              tmpPin = val;
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
        SizedBox(height: 60.h),
        //continue button
        SizedBox(
            height: 56.h,
            width: 343.w,
            child: Obx(() => ElevatedButton(
                onPressed: _controller.enableButton.value
                    ? () {
                  setMPin();
                }
                    : null,
                child:
                Text(_controller.isConfirmPin.value == true ? "Confirm MPin" : 'Continue')))),
          Obx((){
            return _controller.isConfirmPin.value ? SizedBox(height: AppHelpers.isTablet() ? 56.h : 20.h) : const SizedBox();
          }),
        //forgot MPin button / start again
        Obx((){
          return _controller.isError.value ? TextButton(
            onPressed: () {
              _textEditingController.clear();
              _controller.isConfirmPin.value = false;
              _controller.isError.value = false;
              _controller.update();
            },
            child: Text(
              'Start Again?',
              style: _appTheme.errorTextStyle(12),
            ),
          ) : const SizedBox();
        }),
        SizedBox(height: 60.h),
      ],
    ),
  );

  void setMPin() {
    if (_controller.isConfirmPin.value == false) {
      pin = tmpPin;
      _controller.isConfirmPin.value = true;
      enableButton = false;
      _controller.update();
      _textEditingController.text = '';
      _textEditingController.clear();
      tmpPin = '';
    } else {
      confirmPin = tmpPin;
      if (confirmPin == pin) {
        _controller.isError.value = false;
        _controller.setMPin(confirmPin);
      } else {
        _controller.isError.value = true;
        _controller.update();
      }
    }
  }
}
