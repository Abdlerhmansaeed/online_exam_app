import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../entities/profile_entity.dart';
import '../repositories/user_profile_repo.dart';
@injectable
class GetUserProfileUseCase {
  final UserProfileRepo userProfileRepo;

  GetUserProfileUseCase({required this.userProfileRepo});

  Future<Either<String, ProfileEntity>> call() async {
    var response = await userProfileRepo.getUserDetails();
    return response;
  }
}