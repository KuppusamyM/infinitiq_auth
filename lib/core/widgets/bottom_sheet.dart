import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

import '../../../../core/localization/appresource.dart';
import '../../../../core/res/images/app_image.dart';
import '../../../../core/res/style/app_theme.dart';
import '../res/color/color.dart';

final AppResource resource = Get.find();
final AppTheme theme = resource.getTheme();
final AppColor color = resource.getColor();
final AppImages images = resource.getImages();

PersistentBottomSheetController appBottomSheet({required BuildContext context, required Widget child, double? height, double? radius, Color? backGroundColor, bool? showClose}) => showBottomSheet(
    context: context,
    elevation: 100,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius ?? 10.0),
    ),
    builder: (builder) => Container(
      height: height ?? 606.h,
      width: 375.w,
      color: backGroundColor,
      padding: EdgeInsets.symmetric(horizontal: 22.w),
      child: Column(
        children: [
          SizedBox(height: 9.h,),
          Container(
            height: 3.8.h,
            width: 43.03.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: colors.bottomSheetGrey
            ),
          ),
          //close
          if(showClose != false || showClose == null)SizedBox(height: 9.h,),
          if(showClose != false || showClose == null)Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () => Get.back(),
              child: Container(
                height: 20.h,
                width: 20.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.black38
                ),
                child: const Center(
                  child: Icon(Icons.close, size: 15,),
                ),
              ),
            ),
          ),
          SizedBox(height: 27.h,),
          ...[child]
        ],
      ),
    )
);