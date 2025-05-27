import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/user_profile/data/models/change_password_request.dart';
import 'package:online_exam_app/Features/user_profile/data/models/change_password_response.dart';
import 'package:online_exam_app/Features/user_profile/data/models/edit_profile_request.dart';
import 'package:online_exam_app/Features/user_profile/data/models/edit_profile_response.dart';
import 'package:online_exam_app/Features/user_profile/domain/entities/profile_entity.dart';
import 'package:online_exam_app/core/helper/api_result.dart';
import 'package:online_exam_app/core/helper/handel_response.dart';
import '../../domain/repositories/user_profile_repo.dart';
import '../data_sources/remote_data_source/user_profile_remote_data_source.dart';

@Injectable(as: UserProfileRepo)
class UserProfileRepoImpl implements UserProfileRepo {
  final UserProfileRemoteDataSource _userProfileRemoteDataSource;

  UserProfileRepoImpl(
      {required UserProfileRemoteDataSource userProfileRemoteDataSource})
      : _userProfileRemoteDataSource = userProfileRemoteDataSource;

  @override
  Future<ApiResult<ChangePasswordResponse>> changePassword(
      {required ChangePasswordRequest changePasswordRequest}) async {
    var response = await _userProfileRemoteDataSource
        .changePassword(changePasswordRequest);
    return handleResponse(response);
  }

  @override
  Future<ApiResult< EditProfileResponse>> editProfile(
      {required EditProfileRequest editProfileRequest}) async {
    var response =
        await _userProfileRemoteDataSource.editUserProfile(editProfileRequest);
    return handleResponse(response);
  }

  @override
  Future<ApiResult< ProfileEntity>> getUserDetails() async {
    var response = await _userProfileRemoteDataSource.getUserDetails();
    var data = response.map(
      (data) {
        return ProfileEntity(
          id: data.user?.Id ?? '',
          firstName: data.user?.firstName ?? '',
          email: data.user?.email ?? '',
          phone: data.user?.phone ?? '',
          lastName: data.user?.lastName ?? '',
          userName: data.user?.username ?? '',
        );
      },
    );
    return handleResponse(data);
  }
}
