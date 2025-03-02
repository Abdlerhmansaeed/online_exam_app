class AppConstant {
  AppConstant._();
  static RegExp emailRegex = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+"
    r"@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?"
    r"(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
  );
  static RegExp passwordRegex = RegExp(
    r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$",
  );

  static RegExp phoneRegex = RegExp(r'^01[0125][0-9]{8}$');
  static const String baseUrl = 'https://exam.elevateegy.com/api/v1';
  static const String allExamsEndPoint = '$baseUrl/exams';
  static const String signupEndPoint = '$baseUrl/auth/signup';
  static const String forgotPasswordEndPoint = '$baseUrl/auth/forgotpassword';
  static const String signInEndPoint = '$baseUrl/auth/signin';
  static const String verifyResetCodeEndPoint = '$baseUrl/auth/verifyResetCode';
  static const String resetPasswordEndPoint = '$baseUrl/auth/resetPassword';
  static const String allSubjectsEndPoint = '$baseUrl/subjects';
  static  String subjectExamsEndPoint(String subjectId) => '$baseUrl/exams?subject=$subjectId'; //subjectExamsEndPoint;
}
