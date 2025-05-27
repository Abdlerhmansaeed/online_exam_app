import 'package:online_exam_app/Features/auth/data/models/response/otp_code_response.dart';
import 'package:online_exam_app/Features/auth/data/models/response/reset_password.dart';
import 'package:online_exam_app/Features/auth/data/models/response/reset_password_verify.dart';
import 'package:online_exam_app/Features/auth/domain/entities/user_entiti.dart';
import 'package:online_exam_app/core/helper/api_result.dart';
import '../../data/models/request_model/forget_password_email_request.dart';
import '../../data/models/request_model/login_request.dart';
import '../../data/models/request_model/otp_code_verify_request.dart';
import '../../data/models/request_model/reset_passowrd_request.dart';
import '../../data/models/request_model/signup_request.dart';

abstract class AuthRepo {
  Future<ApiResult<ResetPasswordVerify>> forgetPasswordEmailVerify(
      {required ForgetPasswordEmailRequest data});
  Future<ApiResult<OtpCodeResponse>> resetCodeVerify(
      {required OtpCodeVerifyRequset data});
  Future<ApiResult<ResetPasswordResponse>> resetPassword(
      {required ResetPasswordRequest data});
  Future< ApiResult<UserEntity>> login({required LoginRequest data});
  Future<ApiResult< UserEntity>> signup({required SignUpRequest data});
}
