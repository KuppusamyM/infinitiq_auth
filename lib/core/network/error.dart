

import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [error, errorCode];

  String get error;

  int get errorCode;
}

class BadRequest extends Failure {
  @override
  String get error => "BAD REQUEST";

  @override
  int get errorCode => 400;
}

class UnAuthorized extends Failure {
  @override
  String get error => "UNAUTHENTICATED";

  @override
  int get errorCode => 401;
}

class Forbidden extends Failure {
  @override
  String get error => "FORBIDDEN";

  @override
  int get errorCode => 403;
}

class UrlNotFound extends Failure {
  @override
  String get error => "NOT FOUND";

  @override
  int get errorCode => 404;
}

class MethodNotAllowed extends Failure {
  @override
  String get error => "METHOD NOT ALLOWED";

  @override
  int get errorCode => 405;
}

class InternalServerError extends Failure {
  @override
  String get error => "SERVER ERROR";

  @override
  int get errorCode => 500;
}

class BadGateway extends Failure {
  @override
  String get error => "BAD GATEWAY";

  @override
  int get errorCode => 502;
}

class ServerUnavailable extends Failure {
  @override
  String get error => "SERVICE UNAVAILABLE";

  @override
  int get errorCode => 503;
}

class GatewayTimeout extends Failure {
  @override
  String get error => "GATEWAY TIMEOUT";

  @override
  int get errorCode => 504;
}



class UnknownError extends Failure {
  @override
  String get error => "Something Went Wrong";

  @override
  int get errorCode => 0;
}

class NoInternetConnection extends Failure {
  @override
  String get error => "No Internet Connection";

  @override
  int get errorCode => 1;
}

class ApiReturnNull extends Failure {
  @override
  String get error => "Api Return Null Value";

  @override
  int get errorCode => 2;
}


class CustomError extends Failure {

  final String? errorMessage;

  CustomError(this.errorMessage);

  @override
  String get error => errorMessage ?? "";

  @override
  int get errorCode => 5;
}




