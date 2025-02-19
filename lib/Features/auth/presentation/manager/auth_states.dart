abstract class AuthStates {}
class InitialState extends AuthStates{}
class  LoginLoadingState extends AuthStates{}
class LoginSuccessState extends AuthStates{}
class LoginErrorState extends AuthStates{
  String error;
  LoginErrorState(this.error);
} 
class SignupLoadingState extends AuthStates{}
class SignupSuccessState extends AuthStates{}
class SignupErrorState extends AuthStates{
  String error;
  SignupErrorState(this.error);
} 