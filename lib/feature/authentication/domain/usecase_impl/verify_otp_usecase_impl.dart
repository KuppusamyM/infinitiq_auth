
import '../../../../core/network/error.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/utils/shared_preference.dart';
import '../../data/response_model/verify_otp_response.dart';
import '../repository/signin_repository.dart';
import '../usecase/verify_otp_usecase.dart';

class VerifyOtpUseCaseImpl extends VerifyOtpUseCase {
  final SignInRepository _signInRepository;
  final Preference _preference;

  VerifyOtpUseCaseImpl(this._signInRepository, this._preference);

  @override
  Future<Either<Failure, String?>> call(String userId, String phoneNumber,
      String otp) async {
    var data = Either<Failure, String?>();
    var result = await _signInRepository.verifyOtp(userId, phoneNumber, otp);
    if (result.isLeft()) {
      data.setLeft(result.getLeft());
    } else {
      await _setData(result.getRight(), userId);
      data.setRight("");
    }
    return data;
  }

  Future<void> _setData(VerifyOtpResponse right, String userId) async {
    if (right.token != "") {
      _preference.setRefreshToken(right.token);
    }
    await _preference.setUserId(userId);
  }
}
