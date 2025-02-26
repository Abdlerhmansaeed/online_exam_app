import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/auth/data/data_sources/auth_data_source.dart';
import 'package:online_exam_app/core/Constant/app_constant.dart';

import '../../../../core/services/network_srevices.dart';

@Injectable(as: AuthDataSource)
class AuthDataSourceImp implements AuthDataSource {
  final NetworkServices _networkServices;

  AuthDataSourceImp(this._networkServices);

  @override
  Future<Response> login({required String email, required String password}) {
    return _networkServices.dio.post(
      AppConstant.signInEndPoint,
      data: {"email": email, "password": password},
    );
  }

  @override
  Future<Response> signup({
    required String email,
    required String password,
    required String rePassword,
    required String userName,
    required String firstName,
    required String lastName,
    required String phoneNumber,
  }) {
    return _networkServices.dio.post(
      AppConstant.signupEndPoint,
      data: {
        "username": userName,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password,
        "rePassword": rePassword,
        "phone": phoneNumber,
      },
    );
  }

  @override
  Future<Response> forgetPasswordEmailVerify({required String email}) {
    return _networkServices.dio.post(
      AppConstant.forgotPasswordEndPoint,
      data: {"email": email},
    );
  }

  @override
  Future<Response> resetCodeVerify({required String resetCode}) {
    return _networkServices.dio.post(
      AppConstant.verifyResetCodeEndPoint,
      data: {"resetCode": resetCode},
    );
  }

  @override
  Future<Response> resetPassword({required String email, required String password}) {
    return _networkServices.dio.put(
      AppConstant.resetPasswordEndPoint,
      data: {
        "email": email,
        "newPassword": password,
      },
    );
  }
}
