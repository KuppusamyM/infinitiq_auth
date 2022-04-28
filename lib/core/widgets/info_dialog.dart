import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

import '../localization/appresource.dart';
import '../res/color/color.dart';
import '../res/style/app_theme.dart';
import '../utils/app_helpers.dart';

final AppResource resource = Get.find();
final AppTheme _appTheme = Get.find();
final AppColor colors = resource.getColor();

Widget infoDialog(String headerText, String information, String buttonText,
        BuildContext context) =>
    Container(
      height: 220.h,
      width: AppHelpers.isTablet() ? 395.w : 327.w,
      decoration: BoxDecoration(
          color: colors.infoDialogBackgroundColor,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
                color: colors.infoDialogShadowColor,
                offset: const Offset(12, 16),
                spreadRadius: 0,
                blurRadius: 40)
          ]),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 26.0.w),
              child: Text(
                headerText,
                style: _appTheme.bold600(16),
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 26.0.w),
              child: Text(information,
                  style: _appTheme.normal400(AppHelpers.isTablet() ? 18 : 14,
                      color: colors.infoTextColor, height: 1.5.h)),
            ),
            SizedBox(
              height: 42.h,
            ),
            Center(
              child: SizedBox(
                height: 48.h,
                width: AppHelpers.isTablet() ? 343.w : 276.w,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(buttonText),
                ),
              ),
            )
          ],
        ),
      ),
    );

Widget alertDialog(
        String header,
        String information,
        String buttonText1,
        String buttonText2,
        void Function()? onPressed1,
        void Function()? onPressed2,
        BuildContext context) =>
    Container(
      height: 220.h,
      width: AppHelpers.isTablet() ? 395.w : 327.w,
      decoration: BoxDecoration(
          color: colors.infoDialogBackgroundColor,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
                color: colors.infoDialogShadowColor,
                offset: const Offset(12, 16),
                spreadRadius: 0,
                blurRadius: 40)
          ]),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 26.0.w),
              child: Text(header, style: _appTheme.bold600(16),),
            ),

            SizedBox(height: 15.h,),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppHelpers.isTablet() ? 0 : 26.0.w),
              child: Text(
                information,
                style: _appTheme.normal500(AppHelpers.isTablet() ? 18 : 14),
                textAlign: TextAlign.start,
              ),
            ),

            SizedBox(height: 30.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //button 1
                SizedBox(
                  width: 130.w,
                  height: 45.h,
                  child: OutlinedButton(
                    onPressed: onPressed1,
                    child: Text(
                      buttonText1,
                      style: TextStyle(
                          fontSize: 18,
                          color: colors.outlinedButtonTextColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                //button 2
                SizedBox(
                  width: 130.w,
                  height: 45.h,
                  child: ElevatedButton(
                    onPressed: onPressed2,
                    child: Text(buttonText2),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
