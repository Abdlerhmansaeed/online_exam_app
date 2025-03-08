import 'package:dartz/dartz.dart';
import 'package:online_exam_app/Features/user_profile/domain/entities/profile_entity.dart';

import '../../data/models/change_password_request.dart';
import '../../data/models/change_password_response.dart';
import '../../data/models/edit_profile_request.dart';
import '../../data/models/edit_profile_response.dart';


abstract class UserProfileRepo {
  Future<Either<String, ProfileEntity>> getUserDetails();
  Future<Either<String, EditProfileResponse>> editProfile({required EditProfileRequest editProfileRequest});
  Future<Either<String, ChangePasswordResponse>> changePassword({required ChangePasswordRequest changePasswordRequest});
}