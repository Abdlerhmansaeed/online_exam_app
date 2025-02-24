import 'package:dio/dio.dart';
import 'package:online_exam_app/Features/auth/data/data_sources/auth_data_source.dart';
import 'package:online_exam_app/Features/auth/data/data_sources/auth_data_source_imp.dart';
import 'package:online_exam_app/Features/auth/data/models/register_response.dart';
import 'package:online_exam_app/Features/auth/domain/entities/user_entiti.dart';
import 'package:online_exam_app/Features/auth/domain/repositories/auth_repo.dart';

class AuthRepoImp implements AuthRepo {
  AuthDataSource authDataSource = AuthDataSourceImp();

  @override
  Future<UserEntity> login(
      {required String email, required String password}) async {
    try {
      var response =
          await authDataSource.login(email: email, password: password);

      if (response.statusCode == 200 || response.statusCode == 201) {
        RegisterResponse registerResponse =
            RegisterResponse.fromJson(response.data);
        return registerResponse.user!;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception("Unauthorized: Invalid email or password.");
      } else if (e.response?.statusCode == 409) {
        throw Exception("Conflict: This email is already registered.");
      } else {
        throw Exception("Network error: ${e.message}");
      }
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  @override
  Future<UserEntity> signup(
      {required String email,
      required String password,
      required String rePassword,
      required String userName,
      required String firstName,
      required String lastName,
      required String phoneNumber}) async {
    try {
      var response = await authDataSource.signup(
          email: email,
          password: password,
          firstName: firstName,
          lastName: lastName,
          userName: userName,
          rePassword: rePassword,
          phoneNumber: phoneNumber);

      if (response.statusCode == 200 || response.statusCode == 201) {
        RegisterResponse registerResponse =
            RegisterResponse.fromJson(response.data);
        return registerResponse.user!;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception("Unauthorized: Invalid email or password.");
      } else if (e.response?.statusCode == 409) {
        throw Exception("Conflict: This email is already registered.");
      } else {
        throw Exception("Network error: ${e.message}");
      }
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }
}
