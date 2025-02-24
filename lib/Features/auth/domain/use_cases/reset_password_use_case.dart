import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/auth/domain/repositories/auth_repo.dart';

import '../entities/user_entiti.dart';
@injectable
class ResetPasswordUseCase {
  AuthRepo authRepo;
  ResetPasswordUseCase({required this.authRepo});
  Future<Either<String, UserEntiti>> call(
      {required String email, required String password}) {
    return authRepo.resetPassword(email: email, password: password);
  }
}
