import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../utils/log.dart';
import '../../widgets/app_snackbar.dart';


mixin BaseController {

  BuildContext? buildContext;

  void setContext(BuildContext? context){
    buildContext = context;
  }

  void showLoader() {
    // ProgressLoader().show(buildContext);

  }

  void hideLoader() {
    Get.back();
  }

  void showError(String? content) {
    Logger.log(content ?? "");
    AppSnackBar(buildContext,content).show();
  }


  void registerAppLifeCycle() {
    SystemChannels.lifecycle.setMessageHandler((msg) async {

      switch (msg) {
        case "AppLifecycleState.resumed":
          onResumed();
          break;
        case "AppLifecycleState.paused":
          onPaused();
          break;
        case "AppLifecycleState.inactive":
          break;
        case "AppLifecycleState.suspending":
          onDetached();
          break;
        default:
      }
    });
  }

  void onResumed() {}
  void onPaused(){}
  void onDetached() {}

}
