import 'package:json_annotation/json_annotation.dart';

part 'otp_code_response.g.dart';

@JsonSerializable()
class OtpCodeResponse {
  @JsonKey(name: "status")
  final String? status;

  OtpCodeResponse ({
    this.status,
  });

  factory OtpCodeResponse.fromJson(Map<String, dynamic> json) {
    return _$OtpCodeResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$OtpCodeResponseToJson(this);
  }
}


