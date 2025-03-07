
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/profile/data/models/change_password_request.dart';

import '../../data/models/Change_password_response.dart';
import '../repositories/profile_repo.dart';

@injectable
class ChangePasswordUseCase {
  ProfileRepo profileRepo;

  ChangePasswordUseCase(this.profileRepo);
   Future<Either<String, ChangePasswordResponse>> call( ChangePasswordRequest changePassword ){
    return profileRepo.changePassword(changePassword);
   }
}