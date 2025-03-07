import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/auth/domain/repositories/auth_repo.dart';
import 'package:online_exam_app/Features/profile/data/models/edit_profile_request.dart';
import 'package:online_exam_app/Features/profile/data/models/edit_profile_response.dart';
import 'package:online_exam_app/Features/profile/data/models/get_user_profile_response.dart';
import 'package:online_exam_app/Features/profile/domain/repositories/profile_repo.dart';


@injectable
class EditProfileUseCase {
  ProfileRepo profileRepo;

  EditProfileUseCase(this.profileRepo);

  Future<Either<String, EditUser>>call(EditProfileRequest editProfile) {
    return profileRepo.editProfile( editProfile);
  }



}