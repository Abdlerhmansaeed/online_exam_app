import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/exceptions/failure.dart';
import '../../../../core/di/di.dart';
import '../../../../core/helper/request_handler.dart';
import '../../../../core/services/web_services.dart';
import '../models/request_model/forget_password_email_request.dart';
import '../models/request_model/login_request.dart';
import '../models/request_model/otp_code_verify_request.dart';
import '../models/request_model/reset_passowrd_request.dart';
import '../models/request_model/signup_request.dart';
import '../models/response/otp_code_response.dart';
import '../models/response/register_response.dart';
import '../models/response/reset_password.dart';
import '../models/response/reset_password_verify.dart';
import 'auth_data_source.dart';

@Injectable(as: AuthDataSource)
class AuthDataSourceImp implements AuthDataSource {
 final WebServices webServices = getIt<WebServices>();

 @override
 Future<Either<Failures, ResetPasswordVerify>> forgetPasswordEmailVerify({required ForgetPasswordEmailRequest data}) async {
  return await RequestHandler.handle(() => webServices.forgetPasswordEmailVerify(data));
 }

 @override
 Future<Either<Failures, RegisterResponse>> login({required LoginRequest data}) async {
  return await RequestHandler.handle(() => webServices.login(data));
 }

 @override
 Future<Either<Failures, OtpCodeResponse>> resetCodeVerify({required OtpCodeVerifyRequset data}) async {
  return await RequestHandler.handle(() => webServices.resetCodeVerify(data));
 }

 @override
 Future<Either<Failures, ResetPasswordResponse>> resetPassword({required ResetPasswordRequest data}) async {
  return await RequestHandler.handle(() => webServices.resetPassword(data));
 }

 @override
 Future<Either<Failures, RegisterResponse>> signup({required SignUpRequest data}) async {
  return await RequestHandler.handle(() => webServices.signup(data));
 }
}
