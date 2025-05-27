import 'package:injectable/injectable.dart';
import 'package:online_exam_app/core/helper/api_result.dart';
import '../entities/profile_entity.dart';
import '../repositories/user_profile_repo.dart';
@injectable
class GetUserProfileUseCase {
  final UserProfileRepo userProfileRepo;

  GetUserProfileUseCase({required this.userProfileRepo});

  Future<ApiResult<ProfileEntity>> call() async {
    var response = await userProfileRepo.getUserDetails();
    return response;
  }
}