import 'package:dartz/dartz.dart';
import 'package:online_exam_app/Features/auth/domain/entities/user_entiti.dart';
import 'package:online_exam_app/Features/profile/data/models/Change_password_response.dart';
import 'package:online_exam_app/Features/profile/data/models/change_password_request.dart';
import 'package:online_exam_app/Features/profile/data/models/edit_profile_request.dart';
import 'package:online_exam_app/Features/profile/data/models/edit_profile_response.dart';
import 'package:online_exam_app/Features/profile/data/models/get_user_profile_response.dart';

abstract class ProfileRepo {
  Future<Either<String, UserProfile>> getUserProfile();
  Future<Either<String, ChangePasswordResponse>> changePassword( ChangePasswordRequest changePassword);
  Future<Either<String, EditUser>> editProfile(EditProfileRequest editProfile);

}
