import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/auth/domain/repositories/auth_repo.dart';

import '../entities/user_entiti.dart';



@injectable
class OtpResetUseCase {
  AuthRepo authRepo;
  OtpResetUseCase(this.authRepo);

  Future<Either<String, UserEntity>> call({required String resetCode}) {
    return authRepo.resetCodeVerify(resetCode: resetCode);
  }
}