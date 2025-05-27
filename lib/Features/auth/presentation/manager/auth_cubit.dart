import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/auth/data/models/request_model/otp_code_verify_request.dart';
import 'package:online_exam_app/Features/auth/data/models/response/otp_code_response.dart';
import 'package:online_exam_app/Features/auth/data/models/response/reset_password.dart';
import 'package:online_exam_app/Features/auth/data/models/response/reset_password_verify.dart';
import 'package:online_exam_app/Features/auth/domain/use_cases/forget_password_use_case.dart';
import 'package:online_exam_app/Features/auth/domain/use_cases/login_use_case.dart';
import 'package:online_exam_app/Features/auth/domain/use_cases/otp_reset_use_case.dart';
import 'package:online_exam_app/Features/auth/domain/use_cases/reset_password_use_case.dart';
import 'package:online_exam_app/Features/auth/domain/use_cases/signup_usecase.dart';
import 'package:online_exam_app/Features/auth/presentation/manager/auth_states.dart';
import 'package:online_exam_app/core/app_manger/app_local_storage/app_local_storage.dart';
import 'package:online_exam_app/core/helper/handle_cubit_states.dart';
import '../../data/models/request_model/forget_password_email_request.dart';
import '../../data/models/request_model/login_request.dart';
import '../../data/models/request_model/reset_passowrd_request.dart';
import '../../data/models/request_model/signup_request.dart';

@injectable
class AuthCubit extends Cubit<AuthStates> {
  AuthCubit(
    this._loginUseCase,
    this._signupUseCase,
    this._forgetPasswordUseCase,
    this._otpResetUseCase,
    this._resetPasswordUseCase,
    this._localStorage,
  ) : super(const AuthStates());

  final LoginUseCase _loginUseCase;
  final SignupUseCase _signupUseCase;
  final ForgetPasswordUseCase _forgetPasswordUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;
  final OtpResetUseCase _otpResetUseCase;
  final AppLocalStorage _localStorage;

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
    await handleCubitStates(
      request: () => _loginUseCase.call(
          data: LoginRequest(
        email: emailController.text,
        password: passwordController.text,
      )),
      emit: (newState) => emit(state.copyWith(
        loginStates: newState,
      )),
      onSuccess: (data) => _localStorage.saveToken(data?.token ?? ''),
    );
  }

  Future<void> signup() async {
    await handleCubitStates(
      request: () => _signupUseCase.call(
          data: SignUpRequest(
        email: emailController.text,
        password: passwordController.text,
        rePassword: rePasswordController.text,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        username: userNameController.text,
        phone: phoneNumberController.text,
      )),
      emit: (newState) => emit(state.copyWith(
        signupStates: newState,
      )),
      onSuccess: (data) => _localStorage.saveToken(data?.token ?? ''),
    );
  }

  Future<void> forgetPasswordEmailVerify() async {
    await handleCubitStates<ResetPasswordVerify>(
      request: () => _forgetPasswordUseCase.call(
        data: ForgetPasswordEmailRequest(
            email: forgetPasswordEmailController.text),
      ),
      emit: (newState) => emit(state.copyWith(
        forgetPasswordStates: newState,
      )),
    );
  }

  Future<void> resetCodeVerify() async {
    await handleCubitStates<OtpCodeResponse>(
      request: () => _otpResetUseCase.call(
        data: OtpCodeVerifyRequset(resetCode: otpController.text),
      ),
      emit: (newState) => emit(state.copyWith(
        otpStates: newState,
      )),
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
      emit: (newState) => emit(state.copyWith(
        resetPasswordStates: newState,
      )),
      onSuccess: (data) => _localStorage.saveToken(data?.token ?? ''),
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
