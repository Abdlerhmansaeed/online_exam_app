import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/auth/data/models/request_model/forget_password_email_request.dart';
import 'package:online_exam_app/Features/auth/data/models/response/reset_password_verify.dart';
import 'package:online_exam_app/Features/auth/domain/repositories/auth_repo.dart';

@injectable
class ForgetPasswordUseCase {
 final AuthRepo _authRepo;

  ForgetPasswordUseCase(this._authRepo);

  Future<Either<String, ResetPasswordVerify>> call(
      {required ForgetPasswordEmailRequest data}) async{
    var response = await _authRepo.forgetPasswordEmailVerify(data: data);
    return response;
  }
}