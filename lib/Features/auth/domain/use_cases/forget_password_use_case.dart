import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/auth/domain/repositories/auth_repo.dart';

import '../entities/user_entiti.dart';

@injectable
class ForgetPasswordUseCase {
  AuthRepo authRepo;

  ForgetPasswordUseCase(this.authRepo);

  Future<Either<String, UserEntity>>call({required String email}) {
    return authRepo.forgetPasswordEmailVerify(email: email);
  }



}