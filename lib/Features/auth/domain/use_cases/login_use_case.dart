import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/auth/data/repositories/auth_repo_imp.dart';
import 'package:online_exam_app/Features/auth/domain/entities/user_entiti.dart';
import 'package:online_exam_app/Features/auth/domain/repositories/auth_repo.dart';

@injectable
class LoginUseCase {
  AuthRepo authRepo;

  LoginUseCase(this.authRepo);
   Future<Either<String, UserEntiti>> call({required String email, required String password}){
    return authRepo.login(email: email, password: password);
   }
}