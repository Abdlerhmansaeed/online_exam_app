import 'package:dartz/dartz.dart';
import 'package:online_exam_app/Features/user_profile/data/models/change_password_request.dart';
import 'package:online_exam_app/Features/user_profile/data/models/change_password_response.dart';
import 'package:online_exam_app/Features/user_profile/data/models/edit_profile_request.dart';
import 'package:online_exam_app/Features/user_profile/data/models/edit_profile_response.dart';
import 'package:online_exam_app/Features/user_profile/data/models/get_user_profile_response.dart';
import 'package:online_exam_app/core/exceptions/failure.dart';

abstract class UserProfileRemoteDataSource {
  Future<Either<Failures , GetUserProfileResponse>> getUserDetails();
  Future<Either<Failures , EditProfileResponse>> editUserProfile(EditProfileRequest data);
  Future<Either<Failures , ChangePasswordResponse>> changePassword(ChangePasswordRequest data);

}
