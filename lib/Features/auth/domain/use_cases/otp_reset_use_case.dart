import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/auth/data/models/response/otp_code_response.dart';
import 'package:online_exam_app/Features/auth/domain/repositories/auth_repo.dart';
import 'package:online_exam_app/core/helper/api_result.dart';

import '../../data/models/request_model/otp_code_verify_request.dart';



@injectable
class OtpResetUseCase {
 final  AuthRepo _authRepo;
  OtpResetUseCase(this._authRepo);

  Future<ApiResult< OtpCodeResponse>> call({required OtpCodeVerifyRequset data}) async{
  var response = await _authRepo.resetCodeVerify(data: data);
    return response;
  }
}