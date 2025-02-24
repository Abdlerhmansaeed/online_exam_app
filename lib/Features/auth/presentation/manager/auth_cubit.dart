import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app/Features/auth/domain/use_cases/login_use_case.dart';
import 'package:online_exam_app/Features/auth/domain/use_cases/signup_usecase.dart';
import 'package:online_exam_app/Features/auth/presentation/manager/auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(InitialState());
  final LoginUseCase _loginUseCase = LoginUseCase();
  final SignupUseCase _signupUseCase = SignupUseCase();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  Future<void> login() async {
    emit(LoginLoadingState());
    try {
      _loginUseCase.call(
          email: emailController.text, password: passwordController.text);
      emit(LoginSuccessState());
    } catch (e) {
      emit(LoginErrorState(e.toString()));
    }
  }

  Future<void> signup() async {
    emit(SignupLoadingState());
    try {
      _signupUseCase.call(
          email: emailController.text,
          password: passwordController.text,
          rePassword: rePasswordController.text,
          userName: userNameController.text,
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          phoneNumber: phoneNumberController.text);
      emit(SignupSuccessState());
    } catch (e) {
      emit(SignupErrorState(e.toString()));
    }
  }
}
