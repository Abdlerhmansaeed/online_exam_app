import 'package:dio/dio.dart';
import 'package:online_exam_app/Features/profile/data/models/change_password_request.dart';
import 'package:online_exam_app/Features/profile/data/models/edit_profile_request.dart';

abstract class ProfileDataSource {
  Future<Response> getUserProfile();
  Future<Response> changePassword(
   ChangePasswordRequest changePassword);

    Future<Response> editProfile(EditProfileRequest editProfile);

}
