import 'package:dartz/dartz.dart';
import 'package:online_exam_app/Features/auth/domain/entities/user_entiti.dart';

abstract class AuthRepo {
  Future<Either<String, UserEntiti>> login({required String email, required String password});
  Future<Either<String, UserEntiti>> signup({
    required String email,
    required String password,
    required String rePassword,
    required String userName,
    required String firstName,
    required String lastName,
    required String phoneNumber,
  });
  Future<Either<String, UserEntiti>> forgetPasswordEmailVerify({required String email});
  Future<Either<String, UserEntiti>> resetCodeVerify({required String resetCode});
  Future<Either<String, UserEntiti>> resetPassword({required String email, required String password});

}
