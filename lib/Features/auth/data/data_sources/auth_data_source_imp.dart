import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/auth/data/data_sources/auth_data_source.dart';
import 'package:online_exam_app/core/services/network_services.dart';

@Injectable(as: AuthDataSource)
class AuthDataSourceImp implements AuthDataSource {
  final NetworkServices _networkServices;

  AuthDataSourceImp(this._networkServices);

  @override
  Future<Response> login({required String email, required String password}) {
    return _networkServices.dio.post(
      'api/v1/auth/signin',
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
      'api/v1/auth/signup',
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
      'api/v1/auth/forgotpassword',
      data: {"email": email},
    );
  }

  @override
  Future<Response> resetCodeVerify({required String resetCode}) {
    return _networkServices.dio.post(
      'api/v1/auth/verifyResetCode',
      data: {"resetCode": resetCode},
    );
  }

  @override
  Future<Response> resetPassword({required String email, required String password}) {
    return _networkServices.dio.put(
      'api/v1/auth/resetPassword',
      data: {
        "email": email,
        "newPassword": password,
      },
    );
  }
}
