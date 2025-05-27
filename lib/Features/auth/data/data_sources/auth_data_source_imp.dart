import 'package:injectable/injectable.dart';
import 'package:online_exam_app/core/helper/api_result.dart';
import 'package:online_exam_app/core/helper/retrofit_handler.dart';
import '../../../../core/di/di.dart';
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
 Future<ApiResult<ResetPasswordVerify>> forgetPasswordEmailVerify({required ForgetPasswordEmailRequest data}) async {
  return await RetrofitHandler.handle(() => webServices.forgetPasswordEmailVerify(data));
 }
 
  @override
  Future<ApiResult<RegisterResponse>> login({required LoginRequest data}) {
    return RetrofitHandler.handle(() => webServices.login(data));
  }
 
  @override
  Future<ApiResult<OtpCodeResponse>> resetCodeVerify({required OtpCodeVerifyRequset data}) {
    return RetrofitHandler.handle(() => webServices.resetCodeVerify(data));
  }
 
  @override
  Future<ApiResult<ResetPasswordResponse>> resetPassword({required ResetPasswordRequest data}) {
    return RetrofitHandler.handle(() => webServices.resetPassword(data));
  }
 
  @override
  Future<ApiResult<RegisterResponse>> signup({required SignUpRequest data}) {
    return RetrofitHandler.handle(() => webServices.signup(data));
  }


}
