import 'package:online_exam_app/Features/auth/domain/entities/user_entiti.dart';

abstract class AuthStates {}
class InitialState extends AuthStates{}
class  LoginLoadingState extends AuthStates{}
class LoginSuccessState extends AuthStates{
  UserEntiti userEntiti;
  LoginSuccessState(this.userEntiti);
}
class LoginErrorState extends AuthStates{
  String error;
  LoginErrorState(this.error);
} 
class SignupLoadingState extends AuthStates{}
class SignupSuccessState extends AuthStates{
  UserEntiti userEntiti;
  SignupSuccessState(this.userEntiti);
}
class SignupErrorState extends AuthStates{
  String error;
  SignupErrorState(this.error);
}


class ForgetPasswordLoadingState extends AuthStates{}
class ForgetPasswordSuccessState extends AuthStates{
  UserEntiti userEntiti;
  ForgetPasswordSuccessState(this.userEntiti);
}
class ForgetPasswordErrorState extends AuthStates{
  String error;
  ForgetPasswordErrorState(this.error);
}
class OtpLoadingState extends AuthStates{}
class OtpSuccessState extends AuthStates{
  UserEntiti userEntiti;
  OtpSuccessState(this.userEntiti);
}
class OtpErrorState extends AuthStates{
  String error;
  OtpErrorState(this.error);
}

class ResetPasswordLoadingState extends AuthStates{}
class ResetPasswordSuccessState extends AuthStates{
  UserEntiti userEntiti;
  ResetPasswordSuccessState(this.userEntiti);
}
class ResetPasswordErrorState extends AuthStates{
  String error;
  ResetPasswordErrorState(this.error);
}
