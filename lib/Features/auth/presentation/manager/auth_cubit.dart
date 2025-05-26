import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/auth/data/models/request_model/otp_code_verify_request.dart';
import 'package:online_exam_app/Features/auth/data/models/response/otp_code_response.dart';
import 'package:online_exam_app/Features/auth/data/models/response/reset_password.dart';
import 'package:online_exam_app/Features/auth/data/models/response/reset_password_verify.dart';
import 'package:online_exam_app/Features/auth/domain/entities/user_entiti.dart';
import 'package:online_exam_app/Features/auth/domain/use_cases/forget_password_use_case.dart';
import 'package:online_exam_app/Features/auth/domain/use_cases/login_use_case.dart';
import 'package:online_exam_app/Features/auth/domain/use_cases/otp_reset_use_case.dart';
import 'package:online_exam_app/Features/auth/domain/use_cases/reset_password_use_case.dart';
import 'package:online_exam_app/Features/auth/domain/use_cases/signup_usecase.dart';
import 'package:online_exam_app/Features/auth/presentation/manager/auth_states.dart';
import 'package:online_exam_app/core/app_manger/app_local_storage/app_local_storage.dart';
import 'package:online_exam_app/core/base_states/base_states.dart';

import '../../../../core/helper/handel_cubit_states.dart';
import '../../../../core/services/shared_prefs.dart';
import '../../data/models/request_model/forget_password_email_request.dart';
import '../../data/models/request_model/login_request.dart';
import '../../data/models/request_model/reset_passowrd_request.dart';
import '../../data/models/request_model/signup_request.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(
    this._loginUseCase,
    this._signupUseCase,
    this._forgetPasswordUseCase,
    this._otpResetUseCase,
    this._resetPasswordUseCase,
    this._localStorage,
  ) : super(const AuthState());

  final LoginUseCase _loginUseCase;
  final SignupUseCase _signupUseCase;
  final ForgetPasswordUseCase _forgetPasswordUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;
  final OtpResetUseCase _otpResetUseCase;
  AppLocalStorage _localStorage;

  // Form Keys
  final GlobalKey<FormState> forgotPasswordFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> resetPasswordFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  // Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();
  final userNameController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final forgetPasswordEmailController = TextEditingController();
  final otpController = TextEditingController();

  final ValueNotifier<bool> checkBoxValue = ValueNotifier<bool>(false);

  Future<void> login() async {
    await handleCubitStates<UserEntity>(
      request: () => _loginUseCase.call(
        data: LoginRequest(
          email: emailController.text,
          password: passwordController.text,
        ),
      ),
      onLoading: () =>
          emit(state.copyWith(loginStates: const BaseStates.loading())),
      onSuccess: (user) async => {
        await _localStorage.saveToken(user.token),
        emit(state.copyWith(loginStates: BaseStates.success(user)))
      },
      onError: (error) =>
          emit(state.copyWith(loginStates: BaseStates.error(error))),
    );
  }

  Future<void> signup() async {
    await handleCubitStates<UserEntity>(
      request: () => _signupUseCase.call(
        data: SignUpRequest(
          username: userNameController.text,
          email: emailController.text,
          password: passwordController.text,
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          phone: phoneNumberController.text,
          rePassword: rePasswordController.text,
        ),
      ),
      onLoading: () =>
          emit(state.copyWith(signupStates: const BaseStates.loading())),
      onSuccess: (user) async {
        await _localStorage.saveToken(user.token);
        emit(state.copyWith(signupStates: BaseStates.success(user)));
      },
      onError: (error) =>
          emit(state.copyWith(signupStates: BaseStates.error(error))),
    );
  }

  Future<void> forgetPasswordEmailVerify() async {
    await handleCubitStates<ResetPasswordVerify>(
      request: () => _forgetPasswordUseCase.call(
        data: ForgetPasswordEmailRequest(
            email: forgetPasswordEmailController.text),
      ),
      onLoading: () => emit(
          state.copyWith(forgetPasswordStates: const BaseStates.loading())),
      onSuccess: (success) => emit(
          state.copyWith(forgetPasswordStates: BaseStates.success(success))),
      onError: (error) =>
          emit(state.copyWith(forgetPasswordStates: BaseStates.error(error))),
    );
  }

  Future<void> resetCodeVerify() async {
    await handleCubitStates<OtpCodeResponse>(
      request: () => _otpResetUseCase.call(
        data: OtpCodeVerifyRequset(resetCode: otpController.text),
      ),
      onLoading: () =>
          emit(state.copyWith(otpStates: const BaseStates.loading())),
      onSuccess: (response) =>
          emit(state.copyWith(otpStates: BaseStates.success(response))),
      onError: (error) =>
          emit(state.copyWith(otpStates: BaseStates.error(error))),
    );
  }

  Future<void> resetPassword() async {
    await handleCubitStates<ResetPasswordResponse>(
      request: () => _resetPasswordUseCase.call(
        data: ResetPasswordRequest(
          email: forgetPasswordEmailController.text,
          newPassword: passwordController.text,
        ),
      ),
      onLoading: () =>
          emit(state.copyWith(resetPasswordStates: const BaseStates.loading())),
      onSuccess: (response) => emit(
          state.copyWith(resetPasswordStates: BaseStates.success(response))),
      onError: (error) =>
          emit(state.copyWith(resetPasswordStates: BaseStates.error(error))),
    );
  }

  void rememberMe(bool newValue) async {
    checkBoxValue.value = newValue;
    await _localStorage.saveRememberMe(checkBoxValue.value);
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    userNameController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
    forgetPasswordEmailController.dispose();
    otpController.dispose();
    checkBoxValue.dispose();
    return super.close();
  }
}
