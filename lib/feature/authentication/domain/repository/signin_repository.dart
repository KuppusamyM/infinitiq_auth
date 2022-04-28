import '../../../../core/network/error.dart';
import '../../../../core/utils/either.dart';
import '../../data/response_model/generate_otp_response.dart';
import '../../data/response_model/verify_otp_response.dart';

abstract class SignInRepository {
  Future<Either<Failure, GenerateOtpResponse>> generateOtp(String uId, String mobileNumber);

  Future<Either<Failure, VerifyOtpResponse>> verifyOtp(String userId,String phoneNumber,String otp);

  Future<Either<Failure, String>> setMPin(String mPin,String refreshToken);

  Future<Either<Failure, String>> loginWithMpin(String mPin, String userId,String token);
}
