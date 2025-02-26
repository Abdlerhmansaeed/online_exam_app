import '../../domain/entities/user_entiti.dart';

/// resetCode : "429392"

class OtpCodeResponse extends UserEntity{
  OtpCodeResponse({
      String? resetCode,}){
    _resetCode = resetCode;
}

  OtpCodeResponse.fromJson(dynamic json) {
    _resetCode = json['resetCode'];
  }
  String? _resetCode;

  String? get resetCode => _resetCode;

}