import 'package:dio/dio.dart';

const baseUrl = "http://ec2-13-232-151-203.ap-south-1.compute.amazonaws.com/";
const userManagement = "api/user-management/";
const generateOtpUrl = userManagement + "generate-otp";
const verifyOtpUrl = userManagement + "verify-otp";
const setMPinUrl = userManagement + "set-mpin";
const setMPinLoginUrl = userManagement + "mpin-login";

const student = "api/content/student/";
String getLearningModule(String id) => baseUrl + student + "learning-modules/$id";
String getPostClarification() => baseUrl + student + "clarifications/";
String updateStatusClarification(String id) => baseUrl + student + "clarifications/$id/";
String getChapterContents(String id) => baseUrl + student + "chapter-contents/$id";
String setVideoViewed(String id) => baseUrl + student + "chapter-contents/mark-viewed/$id";
String getSubjectDetail(String id) => baseUrl + student + "subject-details/$id";
String getQuestions(String id,String questionType) => baseUrl + student + "questions/$id/$questionType";
String checkAnswersUrl(String id,String questionType) => baseUrl + student + "questions/check-answers/$id/$questionType";

const String clarificationsUrl = baseUrl + student + 'clarifications';

Options getHeader(String token){
  return Options(
    headers: {
      "authorization": "Bearer $token",
    },
  );
}

Options getAuthorizationHeader(String token){
  return Options(
    headers: {
      "Authorization": "Bearer $token",
    },
  );
}
