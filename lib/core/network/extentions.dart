import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as _get;

import '../utils/either.dart';
import '../utils/log.dart';
import '../utils/pages_path.dart';
import 'error.dart';

final AuthPageNavigator _navigator = _get.Get.find();

extension NetworkInterceptor on Response<dynamic> {
  Future<Either<Failure, String>> getResult({bool moveToMpin = true}) async {
    var result = Either<Failure, String>();
    if (statusCode == 200 || statusCode == 201) {
      if (data == null) {
        result.setLeft(ApiReturnNull());
      } else {
        if (result is String) {
          result.setRight(data);
          Logger.log(data);
        } else {
          result.setRight(json.encode(data));
          Logger.log(const JsonEncoder().convert(data).toString());
        }
      }
    } else {
      result.setLeft(statusCode.toString().getFailureType(moveToMpin : moveToMpin));
    }
    return result;
  }
}

extension ErrorCodeHandler on String? {


  Failure getFailureType({bool moveToMpin = true}) {
    Failure result = UnknownError();

    if ((this ?? "").contains(BadRequest().errorCode.toString())) {
      result = BadRequest();
    } else if ((this ?? "").contains(UnAuthorized().errorCode.toString())) {
      result = UnAuthorized();
      _navigator.offAllNamed(_navigator.pinLogin);
    } else if ((this ?? "").contains(Forbidden().errorCode.toString())) {
      result = Forbidden();
    } else if ((this ?? "").contains(UrlNotFound().errorCode.toString())) {
      result = UrlNotFound();
    } else if ((this ?? "").contains(MethodNotAllowed().errorCode.toString())) {
      result = MethodNotAllowed();
    } else if ((this ?? "")
        .contains(InternalServerError().errorCode.toString())) {
      result = InternalServerError();
    } else if ((this ?? "").contains(BadGateway().errorCode.toString())) {
      result = BadGateway();
    } else if ((this ?? "")
        .contains(ServerUnavailable().errorCode.toString())) {
      result = ServerUnavailable();
    } else if ((this ?? "").contains(GatewayTimeout().errorCode.toString())) {
      result = GatewayTimeout();
    } else {
      result = UnknownError();
    }
    return result;
  }
}

extension DioErrorHandling on DioError {
  Failure getDioError({bool moveToMpin = true}) {
    Failure result = UnknownError();
    result = message.getFailureType(moveToMpin : moveToMpin);
    return result;
  }
}
