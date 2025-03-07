import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/auth/domain/repositories/auth_repo.dart';
import 'package:online_exam_app/Features/profile/data/models/get_user_profile_response.dart';
import 'package:online_exam_app/Features/profile/domain/repositories/profile_repo.dart';


@injectable
class GetUserProfileUseCase {
  ProfileRepo profileRepo;

  GetUserProfileUseCase(this.profileRepo);

  Future<Either<String, UserProfile>>call() {
    return profileRepo.getUserProfile();
  }



}