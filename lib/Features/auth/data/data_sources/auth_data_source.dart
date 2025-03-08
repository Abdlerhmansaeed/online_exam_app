
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:online_exam_app/Features/auth/data/models/request_model/reset_passowrd_request.dart';
import 'package:online_exam_app/Features/auth/data/models/response/register_response.dart';

import '../../../../core/exceptions/failure.dart';
import '../models/request_model/forget_password_email_request.dart';
import '../models/request_model/login_request.dart';
import '../models/request_model/otp_code_verify_request.dart';
import '../models/request_model/signup_request.dart';
import '../models/response/otp_code_response.dart';
import '../models/response/reset_password.dart';
import '../models/response/reset_password_verify.dart';

abstract class AuthDataSource {
  Future<Either<Failures, RegisterResponse>> login({required LoginRequest data});
  Future<Either<Failures, RegisterResponse>> signup(
      {required SignUpRequest data});

  Future<Either<Failures, ResetPasswordVerify>> forgetPasswordEmailVerify({required ForgetPasswordEmailRequest data});
  Future<Either<Failures, OtpCodeResponse>> resetCodeVerify({required OtpCodeVerifyRequset data});
  Future<Either<Failures, ResetPasswordResponse>> resetPassword({required ResetPasswordRequest data});
}