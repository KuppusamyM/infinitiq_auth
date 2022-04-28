


import '../../../../core/network/error.dart';
import '../../../../core/utils/either.dart';

abstract class VerifyOtpUseCase {
  Future<Either<Failure,String?>> call(String userId,String phoneNumber,String otp);
}