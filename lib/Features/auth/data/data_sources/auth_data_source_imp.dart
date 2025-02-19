import 'package:dio/src/response.dart';
import 'package:online_exam_app/Features/auth/data/data_sources/auth_data_source.dart';
import 'package:online_exam_app/core/services/network_srevices.dart';

class AuthDataSourceImp implements AuthDataSource {
  NetworkSrevices networkSrevices = NetworkSrevices();

  @override
  Future<Response> login({required String email, required String password}) {
    return networkSrevices.dio.post('api/v1/auth/signin',
        data: {"email": email, "password": password});
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
    return networkSrevices.dio.post('api/v1/auth/signup', data: {
      "username": userName,
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "password": password,
      "rePassword": password,
      "phone": phoneNumber,
    });
  }
}
