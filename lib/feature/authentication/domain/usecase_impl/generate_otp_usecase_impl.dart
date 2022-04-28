

import '../../../../core/network/error.dart';
import '../../../../core/utils/either.dart';
import '../../data/response_model/generate_otp_response.dart';
import '../repository/signin_repository.dart';
import '../usecase/generate_otp_usecase.dart';

class GenerateOtpUseCaseImpl implements GenerateOtpUseCase {
  final SignInRepository _signInRepository;

  GenerateOtpUseCaseImpl(this._signInRepository);

  @override
  Future<Either<Failure, String?>> call(String uId, String mobileNumber) async {
    var data = Either<Failure, String?>();
    var result = await _signInRepository.generateOtp(uId, mobileNumber);
    if (result.isLeft()) {
      data.setLeft(result.getLeft());
    } else {
      data.setRight(result.getRight().detail);
    }
    return data;
  }
}
