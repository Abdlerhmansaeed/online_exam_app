import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/auth/data/data_sources/auth_data_source.dart';
import 'package:online_exam_app/Features/auth/data/models/Forget_password_response.dart';
import 'package:online_exam_app/Features/auth/data/models/otp_code_response.dart';
import 'package:online_exam_app/Features/auth/data/models/register_response.dart';
import 'package:online_exam_app/Features/auth/domain/entities/user_entiti.dart';
import 'package:online_exam_app/Features/auth/domain/repositories/auth_repo.dart';
import 'package:online_exam_app/core/services/shared_prefs.dart';

@Injectable(as: AuthRepo)
class AuthRepoImp implements AuthRepo {
  AuthDataSource authDataSource;

  AuthRepoImp(this.authDataSource);

  @override
  Future<Either<String, UserEntity>> login(
      {required String email, required String password}) async {
    try {
      var response =
      await authDataSource.login(email: email, password: password);

      if (response.statusCode == 200 || response.statusCode == 201) {
        RegisterResponse registerResponse =
        RegisterResponse.fromJson(response.data);
        SharedPrefs().saveString("token", registerResponse.token ?? "");
        return right(registerResponse.user!);
      } else {
        return left(response.data["message"]);
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
  Future<Either<String, UserEntity>> signup({required String email,
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
        SharedPrefs().saveString("token", registerResponse.token ?? "");

        return right(registerResponse.user!);
      } else {
        return left(response.data["message"]);
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
  Future<Either<String, UserEntity>> forgetPasswordEmailVerify(
      {required String email}) async {
    try {
      var response = await authDataSource.forgetPasswordEmailVerify(
        email: email,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        ForgetPasswordResponse forgetPasswordResponse =
        ForgetPasswordResponse.fromJson(response.data);

        return right(UserEntity(
          message: forgetPasswordResponse.message,
          info: forgetPasswordResponse.info,
        ),);
      } else {
        return left(response.data["message"]);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception("Unauthorized: Invalid email or password.");
      } else if (e.response?.statusCode == 409) {
        throw Exception("Conflict: This email is invalid.");
      } else {
        throw Exception("Network error: ${e.message}");
      }
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  @override
  Future<Either<String, UserEntity>> resetCodeVerify(
      {required String resetCode}) async {
    try {
      var response = await authDataSource.resetCodeVerify(
        resetCode: resetCode,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        OtpCodeResponse otpCodeResponse =
        OtpCodeResponse.fromJson(response.data);

        return right(UserEntity(
          message: otpCodeResponse.resetCode,
        ),);
      } else {
        return left(response.data["message"]);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception("Unauthorized: Invalid email or password.");
      } else if (e.response?.statusCode == 409) {
        throw Exception("Conflict: This email is invalid.");
      } else {
        throw Exception("Network error: ${e.message}");
      }
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  @override
  Future<Either<String, UserEntity>> resetPassword(
      {required String email, required String password}) async {
    try {
      var response = await authDataSource.resetPassword(
          email: email,
          password: password
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        RegisterResponse registerResponse =
        RegisterResponse.fromJson(response.data);

        return right(UserEntity(
          message: registerResponse.message,
          token: registerResponse.token
        ),);
      } else {
        return left(response.data["message"]);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception("Unauthorized: Invalid email or password.");
      } else if (e.response?.statusCode == 409) {
        throw Exception("Conflict: This email is invalid.");
      } else {
        throw Exception("Network error: ${e.message}");
      }
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }
}