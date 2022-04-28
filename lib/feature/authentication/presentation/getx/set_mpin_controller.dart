import 'package:get/get.dart';


import '../../../../core/base/controller/base_controller.dart';
import '../../../../core/network/error.dart';
import '../../../../core/utils/pages_path.dart';
import '../../domain/usecase/setmpin_usecase.dart';

class SetMPinController extends GetxController with BaseController {
  final SetMPinUseCase _useCaseImpl;
  final AuthPageNavigator _navigator;
  RxBool isConfirmPin = false.obs;
  RxBool isError = false.obs;
  RxBool enableButton = false.obs;

  SetMPinController(this._useCaseImpl, this._navigator);

  Future<void> setMPin(String confirmPin) async {
    var data = await _useCaseImpl.call(confirmPin);
    if (data.isLeft()) {
      if(data.getLeft().errorCode == UnAuthorized().errorCode){
        _navigator.offAllNamed(_navigator.signIn);
      }else{
        showError(data.getLeft().error);
      }
    } else {
      _navigator.navigateTo(_navigator.pinLogin);
    }
  }
}
