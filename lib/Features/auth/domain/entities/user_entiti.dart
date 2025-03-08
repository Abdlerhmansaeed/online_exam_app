import '../../data/models/response/register_response.dart';

class UserEntity {
  final String userName;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;
  final String? password;
  final String? rePassword;
  final String? message;
  final String? resetCode;
  final String token;

  UserEntity({
    required this.userName,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.token,
    this.password,
    this.rePassword,
    this.message,
    this.resetCode,
  });

  factory UserEntity.fromRegisterResponse(RegisterResponse response) {
    return UserEntity(
      userName: response.user?.username ?? '',
      firstName:response.user?.firstName ?? '',
      lastName: response.user?.lastName ?? '',
      phoneNumber: response.user?.phone?? "",
      email: response.user?.email ?? '',
      token: response.token ?? '',
      message: response.message?? '',
    );
  }
}
