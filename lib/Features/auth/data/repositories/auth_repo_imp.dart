import 'package:dartz/dartz.dart';
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
import 'package:online_exam_app/core/services/shared_prefs.dart';
import '../../../../core/helper/handel_response.dart';

@Injectable(as: AuthRepo)
class AuthRepoImp implements AuthRepo {
  final AuthDataSource authDataSource;

  AuthRepoImp(this.authDataSource);

  @override
  Future<Either<String, UserEntity>> login({required LoginRequest data}) async {
    var response = await authDataSource.login(data: data);
    return handleResponse(response).map((loginResponse) {
      SharedPrefs().saveString('token', loginResponse.token ?? "");
      return UserEntity.fromRegisterResponse(loginResponse);
    });
  }

  @override
  Future<Either<String, ResetPasswordVerify>> forgetPasswordEmailVerify({required ForgetPasswordEmailRequest data}) async {
    var response = await authDataSource.forgetPasswordEmailVerify(data: data);
    return handleResponse(response);
  }

  @override
  Future<Either<String, OtpCodeResponse>> resetCodeVerify({required OtpCodeVerifyRequset data}) async {
    var response = await authDataSource.resetCodeVerify(data: data);
    return handleResponse(response);
  }

  @override
  Future<Either<String, ResetPasswordResponse>> resetPassword({required ResetPasswordRequest data}) async {
    var response = await authDataSource.resetPassword(data: data);
    return handleResponse(response);
  }

  @override
  Future<Either<String, UserEntity>> signup({required SignUpRequest data}) async {
    var response = await authDataSource.signup(data: data);
    return handleResponse(response).map((registerResponse) {
      SharedPrefs().saveString('token', registerResponse.token ?? "");
      return UserEntity.fromRegisterResponse(registerResponse);
    });
  }
}
