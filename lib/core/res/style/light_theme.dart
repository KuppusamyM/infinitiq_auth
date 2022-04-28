import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

import '../../localization/appresource.dart';
import '../../utils/app_helpers.dart';
import '../color/color.dart';
import 'app_theme.dart';

final AppResource resource = Get.find();
final AppColor colors = resource.getColor();

class LightAppTheme implements AppTheme{

  @override
  ThemeData get getAppTheme => ThemeData(
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.white,
        ),
        elevation: 0,
        iconTheme: IconThemeData(
          color: colors.elevatedButtonColor,
        ),
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(
            fontSize: AppHelpers.isTablet() ? 32.sp : 16.sp,
            fontWeight: FontWeight.w600,
            color: colors.appBarThemeColor),
      ),
      /*switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.all<Color>(colors.ElevatedButtonColor)),*/
      fontFamily: 'sfPro',
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.all<Color>(colors.textButtonColor),
        checkColor: MaterialStateProperty.all<Color>(colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.sp))
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.disabled)) {
                    return colors.elevatedButtonDisabledColor;
                  }
                    return colors.elevatedButtonColor;// Use the component's default.
                },
              ),
              textStyle: MaterialStateProperty.resolveWith<TextStyle>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.disabled)) {
                    return TextStyle(
                        fontSize: 17.sp, color: colors.elevatedButtonColor, fontWeight: FontWeight.w500);
                  }
                  return TextStyle(
                      fontSize: 17.sp, color: colors.elevatedButtonTextColor, fontWeight: FontWeight.w500);// Use the component's default.
                },
              ),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.sp)))
          ),
          /*style: ElevatedButton.styleFrom(
            textStyle: TextStyle(
                fontSize: 18, color: colors.elevatedButtonTextColor, fontWeight: FontWeight.w500),
            primary: colors.elevatedButtonColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),

          )*/),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              textStyle:  TextStyle(
                  fontSize: 12.sp, color: colors.textButtonColor, fontWeight: FontWeight.w600),
              primary: colors.textButtonColor
          )
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
                side: BorderSide(width: 1, color: colors.outlinedButtonBorderColor),
                borderRadius: BorderRadius.circular(8.0)),
            primary: colors.outlinedButtonTextColor,
          )
      ),
  );

  @override
  TextStyle bold600(double fontSize, {Color? color, double? height}) => TextStyle(
      fontSize: fontSize.sp,
      height: height,
      fontWeight: FontWeight.w600,
      color: color ?? colors.textColor);

  @override
   TextStyle normal500(double fontSize, {Color? color, double? height}) => TextStyle(
      fontSize: fontSize.sp,
      fontWeight: FontWeight.w500,
      height: height,
      color: color ?? colors.textColor);

  @override
   TextStyle errorTextStyle(double fontSize, {Color? color, double? height}) => TextStyle(
      fontSize: fontSize.sp,
      fontWeight: FontWeight.w500,
      color: color ?? colors.textFieldErrorColor);

  @override
   TextStyle textFieldHintStyle({Color? color, double? height}) => TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: color ?? colors.textFieldHintColor);

  TextStyle textFieldLabelStyle({Color? color}) => TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      color: color ?? colors.searchFieldHintColor);

  @override
   InputDecoration underLineTextFieldDecoration(String hintText) => InputDecoration(
    labelText: hintText,
    labelStyle: textFieldLabelStyle(),
    alignLabelWithHint: false,
    border: UnderlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        width: 0,
        color: Colors.transparent,
      ),
    ),
    enabledBorder: UnderlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        width: 0,
        color: Colors.transparent,
      ),
    ),
    focusedBorder: UnderlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        width: 0,
        color: Colors.transparent,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        width: 0,
        color: Colors.transparent,
      ),
    ),
    hintStyle: textFieldLabelStyle(),
    contentPadding: EdgeInsets.only(left: 16.w, top: 7.5.h),
  );

  @override
  InputDecoration searchFieldDecoration(String hintText,{Color? color}) => InputDecoration(
    filled: true,
    fillColor: color ?? colors.tabBoxBackgroundColor,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        width: 0,
        color: Colors.transparent,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        width: 0,
        color: Colors.transparent,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        width: 0,
        color: Colors.transparent,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        width: 0,
        color: Colors.transparent,
      ),
    ),
    hintText: hintText,
    prefixIcon: SizedBox( width: 18.58.w, height: 18.99.h, child: Center(child: Image.asset(resource.getImages().searchIcon, width: 18.58.w, height: 18.99.h,))),
    hintStyle: textFieldLabelStyle(),
    contentPadding: EdgeInsets.only(left: 16.w, top: 7.5.h),
  );

  @override
  InputDecoration textFieldDecoration(String hintText) => InputDecoration(
    hintText: hintText,
    border: UnderlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        width: 0,
        color: Colors.transparent,
      ),
    ),
    enabledBorder: UnderlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        width: 0,
        color: Colors.transparent,
      ),
    ),
    focusedBorder: UnderlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        width: 0,
        color: Colors.transparent,
      ),
    ),
    hintStyle: textFieldHintStyle(),
  );

  @override
   BoxDecoration get textFieldBorder => BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: colors.textBoxBorder)
  );

  @override
   BoxDecoration get textFieldFocussedBorder => BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: colors.textBoxFocusedBorder)
  );

  @override
  BoxDecoration corneredBoxDeco(Color color, {double? radius}) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? 5),
        color: color
    );
  }

  @override
  TextStyle normal400(double fontSize, {Color? color, double? height}) =>TextStyle(
        fontSize: fontSize.sp,
        fontWeight: FontWeight.w400,
        height: height,
        color: color ?? colors.textColor);

  @override
  TextStyle bold700(double fontSize, {Color? color, double? height}) => TextStyle(
      fontSize: fontSize.sp,
      fontWeight: FontWeight.w700,
      height: height,
      color: color ?? colors.textColor);
}
