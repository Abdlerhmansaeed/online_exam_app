import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/auth/data/repositories/auth_repo_imp.dart';
import 'package:online_exam_app/Features/auth/domain/entities/user_entiti.dart';
import 'package:online_exam_app/Features/auth/domain/repositories/auth_repo.dart';


@injectable
class SignupUsecase {
  AuthRepo authRepo;

  SignupUsecase(this.authRepo);
  Future<Either<String, UserEntiti>> call({
    required String email,
    required String password,
    required String rePassword,
    required String userName,
    required String firstName,
    required String lastName,
    required String phoneNumber,
  }) {
    return authRepo.signup(
        email: email,
        password: password,
        rePassword: rePassword,
        userName: userName,
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber);
  }
}
