import 'dart:ui';

import '../res/color/color.dart';
import '../res/color/light_color.dart';
import '../res/images/app_image.dart';
import '../res/images/app_image_tablet_impl.dart';
import '../res/images/app_images_mobile_impl.dart';
import '../res/strings/english_string.dart';
import '../res/strings/strings.dart';
import '../res/style/app_theme.dart';
import '../res/style/light_theme.dart';
import '../utils/app_helpers.dart';
import 'appresource.dart';



class AppResourceImpl extends AppResource {

  final List<Locale> _supportedLanguage = [
    const Locale("en"),
  ];

  @override
  AppColor getColor() => LightColor();

  @override
  AppStrings getString() => EnglishStrings();


  @override
  List<Locale> getSupportedLocales() => _supportedLanguage;

  @override
  AppImages getImages(){
    if(AppHelpers.isTablet()){
      return AppImagesTabletImpl();
    }else{
      return AppImagesMobileImpl();
    }
  }

  @override
  AppTheme getTheme() => LightAppTheme();

}
