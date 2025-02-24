import 'package:online_exam_app/Features/auth/domain/entities/user_entiti.dart';

class RegisterResponse {
  String? message;
  String? token;
  User? user;

  RegisterResponse({this.message, this.token, this.user});

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }


}

class User extends UserEntity{
  String? username;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? role;

  String? sId;
  

  User(
      { 
      required this.username,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.phone,
       this.role,
     
      this.sId,
    });


  factory User.fromJson(Map<String, dynamic> json) {
   
   return User(
     username: json['username'],
    firstName: json['firstName'],
    lastName: json['lastName'],
    email: json['email'],
    phone: json['phone'],
    role: json['role'],
    sId: json['_id'],
   );
  }


}
