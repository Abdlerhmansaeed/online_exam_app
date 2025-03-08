class AppConstant {
  AppConstant._();
  static final RegExp emailRegex = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+"
    r"@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?"
    r"(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
  );

  static final RegExp passwordRegex = RegExp(
    r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$",
  );

  static final RegExp phoneRegex = RegExp(r'^01[0125][0-9]{8}$');

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
}
