import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/user_profile/data/models/edit_profile_response.dart';
import 'package:online_exam_app/core/helper/api_result.dart';
import '../../data/models/edit_profile_request.dart';
import '../repositories/user_profile_repo.dart';

@injectable
class EditProfileUseCase {
  final UserProfileRepo _userProfileRepo;

  EditProfileUseCase(this._userProfileRepo);

  Future<ApiResult<EditProfileResponse>> call(
      {required EditProfileRequest data}) async {
    var response = await _userProfileRepo.editProfile(editProfileRequest: data);
    return response;
  }
}
