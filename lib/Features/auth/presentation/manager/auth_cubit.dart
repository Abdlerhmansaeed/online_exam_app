import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/auth/domain/use_cases/forget_password_use_case.dart';
import 'package:online_exam_app/Features/auth/domain/use_cases/login_use_case.dart';
import 'package:online_exam_app/Features/auth/domain/use_cases/otp_reset_use_case.dart';
import 'package:online_exam_app/Features/auth/domain/use_cases/reset_password_use_case.dart';
import 'package:online_exam_app/Features/auth/domain/use_cases/signup_usecase.dart';
import 'package:online_exam_app/Features/auth/presentation/manager/auth_states.dart';
import 'package:online_exam_app/core/base_states/base_states.dart';

import '../../domain/entities/user_entiti.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._loginUseCase,
      this._signupUseCase,
      this._forgetPasswordUseCase,
      this._otpResetUseCase,
      this._resetPasswordUseCase) : super(AuthState());

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
    emit(state.copyWith(loginStates:LoadingState()));
    try {
      var result = await _loginUseCase.call(
        email: emailController.text,
        password: passwordController.text,
      );
      result.fold(
            (failure) => emit(state.copyWith(loginStates: ErrorState(failure))),
            (success) => emit(state.copyWith(loginStates: SuccessState<UserEntity>(success))),
      );
    } catch (e) {
      emit(state.copyWith(loginStates: ErrorState(e.toString())));
    }
  }

  Future<void> signup() async {
    emit(state.copyWith(signupStates:LoadingState()));
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
            (failure) => emit(state.copyWith(signupStates: ErrorState(failure))),
            (success) => emit(state.copyWith(signupStates: SuccessState<UserEntity>(success))),
      );
    } catch (e) {
      emit(state.copyWith(signupStates: ErrorState(e.toString())));
    }
  }

  Future<void> forgetPasswordEmailVerify() async {
    emit(state.copyWith(forgetPasswordStates:LoadingState()));
    try {
      var result = await _forgetPasswordUseCase.call(
        email: forgetPasswordEmailController.text,
      );
      result.fold(
            (failure) => emit(state.copyWith(forgetPasswordStates: ErrorState(failure))),
            (success) => emit(state.copyWith(forgetPasswordStates: SuccessState<UserEntity>(success))),
      );
    } catch (e) {
      emit(state.copyWith(forgetPasswordStates: ErrorState(e.toString())));
    }
  }

  Future<void> resetCodeVerify() async {
    emit(state.copyWith(otpStates:LoadingState()));
    try {
      var result = await _otpResetUseCase.call(
        resetCode: otpController.text,
      );
      result.fold(
            (failure) => emit(state.copyWith(otpStates: ErrorState(failure))),
            (success) => emit(state.copyWith(otpStates: SuccessState<UserEntity>(success))),
      );
    } catch (e) {
      emit(state.copyWith(otpStates: ErrorState(e.toString())));
    }
  }

  Future<void> resetPassword() async {
    emit(state.copyWith(resetPasswordStates:LoadingState()));
    try {
      var result = await _resetPasswordUseCase.call(
        email: forgetPasswordEmailController.text,
        password: passwordController.text,
      );
      result.fold(
            (failure) => emit(state.copyWith(resetPasswordStates: ErrorState(failure))),
            (success) => emit(state.copyWith(resetPasswordStates: SuccessState<UserEntity>(success))),
      );
    } catch (e) {
      emit(state.copyWith(resetPasswordStates: ErrorState(e.toString())));
    }
  }

  Future<void> rememberMe(bool newValue) async {
    checkBoxValue.value = newValue;
  }
}