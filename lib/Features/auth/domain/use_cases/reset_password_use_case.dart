import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/auth/data/models/request_model/reset_passowrd_request.dart';
import 'package:online_exam_app/Features/auth/data/models/response/reset_password.dart';
import 'package:online_exam_app/Features/auth/domain/repositories/auth_repo.dart';
import 'package:online_exam_app/core/helper/api_result.dart';

@injectable
class ResetPasswordUseCase {
  final AuthRepo _authRepo;
  ResetPasswordUseCase({required AuthRepo authRepo}) : _authRepo = authRepo;
  Future<ApiResult<ResetPasswordResponse>> call(
      {required ResetPasswordRequest data}) async {
    var response = await _authRepo.resetPassword(data: data);
    return response;
  }
}
