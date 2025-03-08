import 'package:json_annotation/json_annotation.dart';

part 'reset_password_verify.g.dart';

@JsonSerializable()
class ResetPasswordVerify {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "info")
  final String? info;

  ResetPasswordVerify ({
    this.message,
    this.info,
  });

  factory ResetPasswordVerify.fromJson(Map<String, dynamic> json) {
    return _$ResetPasswordVerifyFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ResetPasswordVerifyToJson(this);
  }
}

