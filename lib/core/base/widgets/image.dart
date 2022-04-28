import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../localization/appresource.dart';


class AssetImages extends StatelessWidget {
  final String path;
  final Color? color;
  final double? height;
  final double? width;
  final BoxFit? fit;

  const AssetImages(this.path,
      {this.color, this.width, this.height, this.fit, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path,
      width: width,
      height: height,
      color: color,
      fit: fit,
    );
  }
}

class AppNetworkImage extends StatelessWidget {
  final AppResource _resource = Get.find();

  final String networkUrl;
  final String placeholder;
  final String errorImage;

  final double? networkImageWidth;
  final double? networkImageHeight;
  final double? placeholderSize;
  final double? errorSize;

  final Color? placeholderColor;
  final Color? errorImageColor;

  final double? cornerRadius;
  final double? elevation;
  final BoxFit? boxFit;

  AppNetworkImage(this.networkUrl, this.placeholder, this.errorImage,
      {this.networkImageHeight,
        this.networkImageWidth,
        this.cornerRadius,
        this.placeholderSize,
        this.errorSize,
        this.placeholderColor,
        this.errorImageColor,
        this.elevation,
        this.boxFit,
        Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation ?? 2,
      clipBehavior: Clip.hardEdge,
      color: _resource.getColor().cardBg,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              cornerRadius ?? 5)),
      child: SizedBox(
          height: networkImageHeight ?? 50,
          width: networkImageWidth ?? 47,
          child: Stack(
            children: [
              Center(
                child: AssetImages(
                  placeholder,
                  color: placeholderColor ??
                      _resource.getColor().cardBg,
                  height:
                  placeholderSize ?? 25,
                  width:
                  placeholderSize ?? 25,
                ),
              ),
              FadeInImage.assetNetwork(
                fit: boxFit,
                height:
                networkImageHeight ?? 50,
                width:
                networkImageWidth ?? 47,
                placeholder: _resource.getImages().transparent,
                image: networkUrl,
                imageErrorBuilder: (context, error, stackTrace) {
                  return Container(
                      height: networkImageHeight ??
                          50,
                      width: networkImageWidth ??
                          47,
                      color: _resource.getColor().cardBg,
                      child: Center(
                          child: AssetImages(
                            errorImage,
                            color: errorImageColor,
                            width:
                            errorSize ?? 25,
                            height:
                            errorSize ?? 25,
                          )));
                },
              )
            ],
          )),
    );
  }

}