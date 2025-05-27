import 'package:online_exam_app/Features/user_profile/data/models/change_password_request.dart';
import 'package:online_exam_app/Features/user_profile/data/models/change_password_response.dart';
import 'package:online_exam_app/Features/user_profile/data/models/edit_profile_request.dart';
import 'package:online_exam_app/Features/user_profile/data/models/edit_profile_response.dart';
import 'package:online_exam_app/Features/user_profile/data/models/get_user_profile_response.dart';
import 'package:online_exam_app/core/helper/api_result.dart';

abstract class UserProfileRemoteDataSource {
  Future<ApiResult< GetUserProfileResponse>> getUserDetails();
  Future<ApiResult< EditProfileResponse>> editUserProfile(EditProfileRequest data);
  Future<ApiResult< ChangePasswordResponse>> changePassword(ChangePasswordRequest data);

}
