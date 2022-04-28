import 'package:flutter/material.dart';
import 'package:infinitiq_auth/core/base/controller/base_controller.dart';

class ScreenScaffold extends StatelessWidget {
  final Widget body;
  final BaseController? controller;
  final double? height;
  final double? width;
  final Color? backGroundColor;
  final bool? resizeToAvoidBottomInset;
  final AppBar? appBar;
  final BottomNavigationBar? bottomNavigationBar;

  const ScreenScaffold(
      {required this.body,
      this.controller,
      this.resizeToAvoidBottomInset,
      this.width = double.infinity,
      this.height = double.infinity,
      this.backGroundColor,
        this.bottomNavigationBar,
        this.appBar,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller?.setContext(context);
    return Scaffold(
      appBar: appBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      backgroundColor: backGroundColor ?? Colors.white,
      body: body,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
