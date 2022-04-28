import 'package:dio/dio.dart';
import 'package:infinitiq_auth/core/network/extentions.dart';

import '../../../../core/network/api_constants.dart';
import '../../../../core/network/error.dart';
import '../../../../core/network/url_constants.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/utils/log.dart';
import '../../domain/repository/signin_repository.dart';
import '../response_model/generate_otp_response.dart';
import '../response_model/verify_otp_response.dart';

class SignInRepositoryImpl implements SignInRepository {
  final Dio _dio;

  SignInRepositoryImpl(this._dio);

  @override
  Future<Either<Failure, GenerateOtpResponse>> generateOtp(
      String uId, String mobileNumber) async {
    var result = Either<Failure, GenerateOtpResponse>();

    Map<String, dynamic> inputData = {
      userIdKey: uId,
      phoneNumberKey: mobileNumber
    };

    try {
      var rawResponse =
          await _dio.post(generateOtpUrl, data: FormData.fromMap(inputData));

      var response = await rawResponse.getResult();

      if (response.isLeft()) {
        result.setLeft(response.getLeft());
      } else {
        var responseModel = generateOtpResponseFromJson(response.getRight());
        result.setRight(responseModel);
      }
    } on Exception catch (e) {
      if (e is DioError) {
        result.setLeft(e.getDioError());
      } else {
        result.setLeft(CustomError(e.toString()));
      }
    }

    return result;
  }

  @override
  Future<Either<Failure, VerifyOtpResponse>> verifyOtp(
      String uId, String mobileNumber, String otp) async {
    var result = Either<Failure, VerifyOtpResponse>();

    Map<String, dynamic> inputData = {
      userIdKey: uId,
      phoneNumberKey: mobileNumber,
      otpKey: otp
    };

    try {
      var rawResponse =
          await _dio.post(verifyOtpUrl, data: FormData.fromMap(inputData));
      var response = await rawResponse.getResult();

      if (response.isLeft()) {
        result.setLeft(response.getLeft());
      } else {
        var responseModel = verifyOtpResponseFromJson(response.getRight());
        result.setRight(responseModel);
        Logger.log("Verify OTP response Header ${result.getRight().token}",);
      }
    } on Exception catch (e) {
      if (e is DioError) {
        result.setLeft(e.getDioError());
      } else {
        result.setLeft(CustomError(e.toString()));
      }
    }
    return result;
  }

  @override
  Future<Either<Failure, String>> setMPin(String mPin, String refreshToken) async{
    Either<Failure, String> result = Either<Failure, String>();

    Logger.log("setMPin Request Header $refreshToken",);

    Map<String, dynamic> inputData = {mPinKey: mPin};
    try {
      var rawResponse = await _dio.patch(
        setMPinUrl,
        data: FormData.fromMap(inputData),
        options: getHeader(refreshToken),
      );
      var response = await rawResponse.getResult();


      if (response.isLeft()) {
        result.setLeft(response.getLeft());
      } else {
        String header = rawResponse.headers.value("updated-token") ?? "";
        result.setRight(header);
        Logger.log("setMPin Response Header $header",);
      }
    } on Exception catch (e) {
      if (e is DioError) {
        result.setLeft(e.getDioError());
      } else {
        result.setLeft(CustomError(e.toString()));
      }
    }
    return result;
  }

  @override
  Future<Either<Failure, String>> loginWithMpin(String mPin, String userId,String token) async{
    Either<Failure, String> result = Either<Failure, String>();

    Logger.log("loginWithMpin Request Header $token",);

    Map<String, dynamic> inputData = {mPinKey: mPin,userIdKey : userId};

    try {
      var rawResponse = await _dio.post(
        setMPinLoginUrl,
        data: FormData.fromMap(inputData),
        options: getHeader(token),
      );
      var response = await rawResponse.getResult(moveToMpin: false);

      if (response.isLeft()) {
        result.setLeft(response.getLeft());
      } else {
        String header = rawResponse.headers.value("updated-token") ?? "";
        result.setRight(header);
        Logger.log("loginWithMpin Response Header $header",);
      }
    } on Exception catch (e) {
      if (e is DioError) {
        result.setLeft(e.getDioError(moveToMpin: false));
      } else {
        result.setLeft(CustomError(e.toString()));
      }
    }
    return result;
  }
}
