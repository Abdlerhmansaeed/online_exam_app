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
  AuthCubit(this._loginUseCase,
      this._signupUseCase,
      this._forgetPasswordUseCase,
      this._otpResetUseCase,
      this._resetPasswordUseCase,) : super(InitialState());

  final LoginUseCase _loginUseCase;
  final SignupUsecase _signupUseCase;
  final ForgetPasswordUseCase _forgetPasswordUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;
  final OtpResetUseCase _otpResetUseCase;

  // Form Keys
  final forgotPasswordFormKey = GlobalKey<FormState>();
  final loginFormKey = GlobalKey<FormState>();
  final otpFormKey = GlobalKey<FormState>();
  final resetPasswordFormKey = GlobalKey<FormState>();
  final signupFormKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController forgetPasswordEmailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();


  final ValueNotifier<bool> checkBoxValue = ValueNotifier<bool>(false);

  Future<void> login() async {
    emit(LoginLoadingState());
    try {
      var result = await _loginUseCase.call(
        email: emailController.text,
        password: passwordController.text,
      );
      result.fold(
            (failure) => emit(LoginErrorState(failure)),
            (success) => emit(LoginSuccessState(success)),
      );
    } catch (e) {
      emit(LoginErrorState(e.toString()));
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
        phoneNumber: phoneNumberController.text,
      );
      result.fold(
            (failure) => emit(SignupErrorState(failure)),
            (success) => emit(SignupSuccessState(success)),
      );
    } catch (e) {
      emit(SignupErrorState(e.toString()));
    }
  }

  Future<void> forgetPasswordEmailVerify() async {
    emit(ForgetPasswordLoadingState());
    try {
      var result = await _forgetPasswordUseCase.call(
        email: forgetPasswordEmailController.text,
      );
      result.fold(
            (failure) => emit(ForgetPasswordErrorState(failure)),
            (success) => emit(ForgetPasswordSuccessState(success)),
      );
    } catch (e) {
      emit(ForgetPasswordErrorState(e.toString()));
    }
  }

  Future<void> resetCodeVerify() async {
    emit(OtpLoadingState());
    try {
      var result = await _otpResetUseCase.call(
        resetCode: otpController.text,
      );
      result.fold(
            (failure) => emit(OtpErrorState(failure)),
            (success) => emit(OtpSuccessState(success)),
      );
    } catch (e) {
      emit(OtpErrorState(e.toString()));
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
            (failure) => emit(ResetPasswordErrorState(failure)),
            (success) => emit(ResetPasswordSuccessState(success)),
      );
    } catch (e) {
      emit(ResetPasswordErrorState(e.toString()));
    }
  }

  Future<void> rememberMe(bool newValue) async {
    checkBoxValue.value = newValue;
  }
}