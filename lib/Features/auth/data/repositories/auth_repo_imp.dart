import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/auth/data/data_sources/auth_data_source.dart';
import 'package:online_exam_app/Features/auth/data/models/request_model/forget_password_email_request.dart';
import 'package:online_exam_app/Features/auth/data/models/request_model/login_request.dart';
import 'package:online_exam_app/Features/auth/data/models/request_model/otp_code_verify_request.dart';
import 'package:online_exam_app/Features/auth/data/models/request_model/reset_passowrd_request.dart';
import 'package:online_exam_app/Features/auth/data/models/request_model/signup_request.dart';
import 'package:online_exam_app/Features/auth/data/models/response/otp_code_response.dart';
import 'package:online_exam_app/Features/auth/data/models/response/reset_password.dart';
import 'package:online_exam_app/Features/auth/data/models/response/reset_password_verify.dart';
import 'package:online_exam_app/Features/auth/domain/entities/user_entiti.dart';
import 'package:online_exam_app/Features/auth/domain/repositories/auth_repo.dart';
import 'package:online_exam_app/core/helper/api_result.dart';
import '../../../../core/helper/handel_response.dart';

@Injectable(as: AuthRepo)
class AuthRepoImp implements AuthRepo {
  final AuthDataSource authDataSource;

  AuthRepoImp(this.authDataSource);

  @override
  Future<ApiResult<UserEntity>> login({required LoginRequest data}) async {
    var response = await authDataSource.login(data: data);
    return handleResponse(response).map((registerResponse) {
      return UserEntity.fromRegisterResponse(registerResponse);
    });
  }

  @override
  Future<ApiResult<ResetPasswordVerify>> forgetPasswordEmailVerify(
      {required ForgetPasswordEmailRequest data}) async {
    var response = await authDataSource.forgetPasswordEmailVerify(data: data);
    return handleResponse(response);
  }

  @override
  Future<ApiResult<OtpCodeResponse>> resetCodeVerify(
      {required OtpCodeVerifyRequset data}) async {
    var response = await authDataSource.resetCodeVerify(data: data);
    return handleResponse(response);
  }

  @override
  Future<ApiResult<ResetPasswordResponse>> resetPassword(
      {required ResetPasswordRequest data}) async {
    var response = await authDataSource.resetPassword(data: data);
    return handleResponse(response);
  }

  @override
  Future<ApiResult<UserEntity>> signup({required SignUpRequest data}) async {
    var response = await authDataSource.signup(data: data);
    return handleResponse(response).map((registerResponse) {
      return UserEntity.fromRegisterResponse(registerResponse);
    });
  }
}
