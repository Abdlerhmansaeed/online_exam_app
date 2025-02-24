
import '../../domain/entities/user_entiti.dart';

class ForgetPasswordResponse extends UserEntiti {
  ForgetPasswordResponse({this.message, this.info}) : super();

  factory ForgetPasswordResponse.fromJson(dynamic json) {
    return ForgetPasswordResponse(
      message: json['message'],
      info: json['info'],
    );
  }

  final String? message;
  final String? info;
}
