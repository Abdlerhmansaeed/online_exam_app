import 'package:dartz/dartz.dart';
import 'package:online_exam_app/Features/auth/domain/entities/user_entiti.dart';

abstract class AuthRepo {
  Future<Either<String, UserEntity>> login({required String email, required String password});
  Future<Either<String, UserEntity>> signup({
    required String email,
    required String password,
    required String rePassword,
    required String userName,
    required String firstName,
    required String lastName,
    required String phoneNumber,
  });
  Future<Either<String, UserEntity>> forgetPasswordEmailVerify({required String email});
  Future<Either<String, UserEntity>> resetCodeVerify({required String resetCode});
  Future<Either<String, UserEntity>> resetPassword({required String email, required String password});

}
