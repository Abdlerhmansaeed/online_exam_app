import 'package:online_exam_app/Features/user_profile/domain/entities/profile_entity.dart';
import 'package:online_exam_app/core/helper/api_result.dart';

import '../../data/models/change_password_request.dart';
import '../../data/models/change_password_response.dart';
import '../../data/models/edit_profile_request.dart';
import '../../data/models/edit_profile_response.dart';


abstract class UserProfileRepo {
  Future<ApiResult<  ProfileEntity>> getUserDetails();
  Future<ApiResult<  EditProfileResponse>> editProfile({required EditProfileRequest editProfileRequest});
  Future<ApiResult<  ChangePasswordResponse>> changePassword({required ChangePasswordRequest changePasswordRequest});
}