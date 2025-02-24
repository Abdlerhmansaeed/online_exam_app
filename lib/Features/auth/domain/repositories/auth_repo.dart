import 'package:online_exam_app/Features/auth/domain/entities/user_entiti.dart';

abstract class AuthRepo {
  Future<UserEntity> login({required String email, required String password});
  Future<UserEntity> signup({
    required String email,
    required String password,
    required String rePassword,
    required String userName,
    required String firstName,
    required String lastName,
    required String phoneNumber,
  });
}
