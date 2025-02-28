import 'package:dio/dio.dart';

abstract class AuthDataSource {
  Future<Response> login({required String email, required String password});
  Future<Response> signup(
      {required String email,
      required String password,
      required String rePassword,
      required String userName,
      required String firstName,
      required String lastName,
      required String phoneNumber});

    Future<Response> forgetPasswordEmailVerify({required String email});
    Future<Response> resetCodeVerify({required String resetCode});
    Future<Response> resetPassword({required String email,required String password});
}
