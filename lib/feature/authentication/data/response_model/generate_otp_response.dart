import 'dart:convert';

GenerateOtpResponse generateOtpResponseFromJson(String str) => GenerateOtpResponse.fromJson(json.decode(str));

String generateOtpResponseToJson(GenerateOtpResponse data) => json.encode(data.toJson());

class GenerateOtpResponse {
  GenerateOtpResponse({
    this.detail,
  });

  String? detail;
  String token = "";

  factory GenerateOtpResponse.fromJson(Map<String, dynamic> json) => GenerateOtpResponse(
    detail: json["detail"],
  );

  Map<String, dynamic> toJson() => {
    "detail": detail,
  };

}