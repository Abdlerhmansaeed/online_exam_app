import 'package:json_annotation/json_annotation.dart';

part 'otp_code_verify_request.g.dart';

@JsonSerializable()
class OtpCodeVerifyRequset {
  @JsonKey(name: "resetCode")
  final String? resetCode;

  OtpCodeVerifyRequset ({
    this.resetCode,
  });

  factory OtpCodeVerifyRequset.fromJson(Map<String, dynamic> json) {
    return _$OtpCodeVerifyRequsetFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$OtpCodeVerifyRequsetToJson(this);
  }
}


