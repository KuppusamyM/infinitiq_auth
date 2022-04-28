


import '../../../../core/network/error.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/utils/shared_preference.dart';
import '../repository/signin_repository.dart';
import '../usecase/login_with_mpin_usecase.dart';

class LoginWithMPinUseCaseImpl extends LoginWithMPinUseCase{

  final SignInRepository _signInRepository;
  final Preference _preference;

  LoginWithMPinUseCaseImpl(this._signInRepository,this._preference);

  @override
  Future<Either<Failure, String>> call(String mPin) async{

    var data = Either<Failure, String>();

    var userId = await _preference.getUserId();
    var token = await _preference.getRefreshToken();
    var result = await _signInRepository.loginWithMpin(mPin,userId ?? "",token ?? "");

    if(result.isLeft()){
      data.setLeft(result.getLeft());
    }else{
      _preference.setRefreshToken(result.getRight());
      data.setRight(result.getRight());
    }

    return data;
  }

}