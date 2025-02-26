class AppConstant {
  AppConstant._();
  static const String baseUrl = 'https://exam.elevateegy.com/api/v1';
  static const String allExamsEndPoint = '$baseUrl/exams';
  static const String signupEndPoint = '$baseUrl/auth/signup';
  static const String forgotPasswordEndPoint = '$baseUrl/auth/forgotpassword';
  static const String signInEndPoint = '$baseUrl/auth/signin';
  static const String verifyResetCodeEndPoint = '$baseUrl/auth/verifyResetCode';
  static const String resetPasswordEndPoint = '$baseUrl/auth/resetPassword';
  static const String allSubjectsEndPoint = '$baseUrl/subjects';
}
