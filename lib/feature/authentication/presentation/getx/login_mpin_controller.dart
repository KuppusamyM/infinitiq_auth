import 'package:get/get.dart';

import '../../../../core/base/controller/base_controller.dart';
import '../../../../core/network/error.dart';
import '../../../../core/utils/app_helpers.dart';
import '../../../../core/utils/pages_path.dart';
import '../../../../core/utils/shared_preference.dart';
import '../../domain/usecase/login_with_mpin_usecase.dart';

class LoginMpinController extends GetxController with BaseController{

  final LoginWithMPinUseCase _loginWithMPinUseCase;
  final AuthPageNavigator _navigator;
  final Preference _preference;
  RxBool enableButton = false.obs;
  RxBool showMPinError = false.obs;

  LoginMpinController(this._loginWithMPinUseCase,this._navigator,this._preference);

  void loginWithPin(String mPin) async{
    var data = await _loginWithMPinUseCase.call(mPin);

    if(data.isLeft()){
      if(data.getLeft().errorCode == Forbidden().errorCode){
        _preference.setLogin(false);
        _navigator.offAllNamed(_navigator.signIn);
      }else{
        showMPinError.value = true;
        showError(data.getLeft().error);
      }

    }else{
      _preference.setLogin(true);
      if(AppHelpers.isTablet()) {
        _navigator.offAllNamed(_navigator.landingScreenTablet);
      } else {
        _navigator.offAllNamed(_navigator.landingScreenMobile);
      }
    }
  }

}