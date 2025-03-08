import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/user_profile/data/models/change_password_response.dart';
import '../../data/models/change_password_request.dart';
import '../repositories/user_profile_repo.dart';
@injectable
class ChangeUserPasswordUseCase {
  final UserProfileRepo _userProfileRepo;

  ChangeUserPasswordUseCase( this._userProfileRepo);

  Future<Either<String, ChangePasswordResponse>> call(
      {required ChangePasswordRequest data}) async {
    var response = await _userProfileRepo.changePassword(changePasswordRequest: data);
    return response;
  }
}