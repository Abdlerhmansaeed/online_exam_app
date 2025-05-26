class ApiConstants {
  ApiConstants._();
  static const String baseUrl = 'https://exam.elevateegy.com/api/v1';
  static const String signupEndPoint = '/auth/signup';
  static const String signInEndPoint = '/auth/signin';
  static const String forgotPasswordEndPoint = '/auth/forgotpassword';
  static const String verifyResetCodeEndPoint = '/auth/verifyResetCode';
  static const String resetPasswordEndPoint = '/auth/resetPassword';

  static const String allSubjectsEndPoint = '/subjects';
  static const String examsEndPoint = '/exams';
  static const String questionEndPoint = '/questions';
  static const String checkAnswerEndPoint = '/questions/check';
  static const String getUserDetailsEndPoint = '/auth/profileData';
  static const String editUserDetailsEndPoint = '/auth/editProfile';
  static const String changePasswordEndPoint = '/auth/changePassword';



  static const int connectionTimeOut = 60;
}
