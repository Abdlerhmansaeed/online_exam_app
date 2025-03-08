import 'package:json_annotation/json_annotation.dart';

part 'forget_password_email_request.g.dart';

@JsonSerializable()
class ForgetPasswordEmailRequest {
  @JsonKey(name: "email")
  final String? email;

  ForgetPasswordEmailRequest ({
    this.email,
  });

  factory ForgetPasswordEmailRequest.fromJson(Map<String, dynamic> json) {
    return _$ForgetPasswordEmailRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ForgetPasswordEmailRequestToJson(this);
  }
}


