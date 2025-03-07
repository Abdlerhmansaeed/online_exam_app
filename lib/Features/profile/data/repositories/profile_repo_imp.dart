import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/auth/data/data_sources/auth_data_source.dart';
import 'package:online_exam_app/Features/auth/data/models/Forget_password_response.dart';
import 'package:online_exam_app/Features/auth/data/models/otp_code_response.dart';
import 'package:online_exam_app/Features/auth/data/models/register_response.dart';
import 'package:online_exam_app/Features/auth/domain/entities/user_entiti.dart';
import 'package:online_exam_app/Features/auth/domain/repositories/auth_repo.dart';
import 'package:online_exam_app/Features/profile/data/data_sources/profile_data_source.dart';
import 'package:online_exam_app/Features/profile/data/models/Change_password_response.dart';
import 'package:online_exam_app/Features/profile/data/models/change_password_request.dart';
import 'package:online_exam_app/Features/profile/data/models/edit_profile_request.dart';
import 'package:online_exam_app/Features/profile/data/models/edit_profile_response.dart';
import 'package:online_exam_app/Features/profile/domain/repositories/profile_repo.dart';
import 'package:online_exam_app/core/services/shared_prefs.dart';

import '../models/get_user_profile_response.dart';

@Injectable(as: ProfileRepo)
class ProfileRepoImp implements ProfileRepo {
  ProfileDataSource profileDataSource;

  ProfileRepoImp(this.profileDataSource);
  @override
  Future<Either<String, UserProfile>> getUserProfile() async{
    try {
      var response =
          await profileDataSource.getUserProfile();

      if (response.statusCode == 200 || response.statusCode == 201) {
        UserProfile profileResponse =
        UserProfile.fromJson(response.data);
        return right(profileResponse);
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
  Future<Either<String, ChangePasswordResponse>> changePassword( ChangePasswordRequest changePassword) async{
    try {
      var response = await profileDataSource.changePassword(
        changePassword
);

      if (response.statusCode == 200 || response.statusCode == 201) {
        ChangePasswordResponse changePasswordResponse =
        ChangePasswordResponse.fromJson(response.data);
        SharedPrefs().saveString("token", changePasswordResponse.token ?? "");

        return right(changePasswordResponse);
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
  Future<Either<String, EditUser>> editProfile(EditProfileRequest editProfile) async{
    try {
      var response =
      await profileDataSource.editProfile(
        editProfile
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        EditUser editprofileResponse =
        EditUser.fromJson(response.data);
        return right(editprofileResponse);
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


}