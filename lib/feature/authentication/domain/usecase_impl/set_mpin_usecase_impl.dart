
import '../../../../core/network/error.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/utils/shared_preference.dart';
import '../repository/signin_repository.dart';
import '../usecase/setmpin_usecase.dart';

class SetMPinUseCaseImpl implements SetMPinUseCase {
  final SignInRepository _signInRepository;
  final Preference _preference;

  SetMPinUseCaseImpl(this._signInRepository, this._preference);

  @override
  Future<Either<Failure, String>> call(String mPin) async {

    var result = Either<Failure, String>();
    var token = await _preference.getRefreshToken();
    var data = await _signInRepository.setMPin(mPin, token ?? "");

    if (data.isLeft()) {
      result.setLeft(data.getLeft());
    } else {
      if (data.getRight() != "") {
        await _preference.setRefreshToken(data.getRight());
      }
      result.setRight("success");
    }

    return result;
  }
}
