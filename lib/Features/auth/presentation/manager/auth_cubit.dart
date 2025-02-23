import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/auth/domain/use_cases/forget_password_use_case.dart';
import 'package:online_exam_app/Features/auth/domain/use_cases/login_use_case.dart';
import 'package:online_exam_app/Features/auth/domain/use_cases/otp_reset_use_case.dart';
import 'package:online_exam_app/Features/auth/domain/use_cases/reset_password_use_case.dart';
import 'package:online_exam_app/Features/auth/domain/use_cases/signup_usecase.dart';
import 'package:online_exam_app/Features/auth/presentation/manager/auth_states.dart';

@injectable
class AuthCubit extends Cubit<AuthStates> {
  AuthCubit(this._loginUseCase, this._signupUseCase,
      this._forgetPasswordUseCase, this._OtpResetUseCase, this._resetPasswordUseCase)
      : super(InitialState());
  final LoginUseCase _loginUseCase;
  final SignupUsecase _signupUseCase;
  final ForgetPasswordUseCase _forgetPasswordUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;
  final forgotPasswordFormKey = GlobalKey<FormState>();
  final loginFormKey = GlobalKey<FormState>();
  final otpFormKey = GlobalKey<FormState>();
  final resetPasswordFormKey = GlobalKey<FormState>();
  final signupFormKey = GlobalKey<FormState>();

  final OtpResetUseCase _OtpResetUseCase;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController forgetPasswordEmailController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  List<String> opts = List.filled(6, "");



  Future<void> login() async {
    emit(LoginLoadingState());
    try {
      var result = await _loginUseCase.call(
          email: emailController.text, password: passwordController.text);
      result.fold(
        (l) {
          emit(LoginErrorState(l));
        },
        (r) {

          emit(LoginSuccessState(r));
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> signup() async {
    emit(SignupLoadingState());
    try {
      var result = await _signupUseCase.call(
          email: emailController.text,
          password: passwordController.text,
          rePassword: rePasswordController.text,
          userName: userNameController.text,
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          phoneNumber: phoneNumberController.text);
      result.fold(
        (l) {
          emit(SignupErrorState(l));
        },
        (r) {
          emit(SignupSuccessState(r));
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> forgetPasswordEmailVerify() async {
    emit(ForgetPasswordLoadingState());
    try {
      var result = await _forgetPasswordUseCase.call(
          email: forgetPasswordEmailController.text);
      result.fold(
        (l) {
          emit(ForgetPasswordErrorState(l));
        },
        (r) {
          emit(ForgetPasswordSuccessState(r));
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> resetCodeVerify() async {
    emit(OtpLoadingState());
    try {
      var result = await _OtpResetUseCase.call(resetCode: otpController.text);
      result.fold(
        (l) {
          emit(OtpErrorState(l));
        },
        (r) {
          emit(OtpSuccessState(r));
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> resetPassword() async {
    emit(ResetPasswordLoadingState());
    try {
      var result = await _resetPasswordUseCase.call(
          email: forgetPasswordEmailController.text,
          password: passwordController.text,
          );
      result.fold(
        (l) {
          emit(ResetPasswordErrorState(l));
        },
        (r) {
          emit(ResetPasswordSuccessState(r));
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }
}
