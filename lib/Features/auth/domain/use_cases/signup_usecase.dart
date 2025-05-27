import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/auth/domain/entities/user_entiti.dart';
import 'package:online_exam_app/Features/auth/domain/repositories/auth_repo.dart';
import 'package:online_exam_app/core/helper/api_result.dart';

import '../../data/models/request_model/signup_request.dart';

@injectable
class SignupUseCase {
  final AuthRepo _authRepo;

  SignupUseCase(this._authRepo);

  Future<ApiResult<UserEntity>> call({required SignUpRequest data}) async {
    var response = await _authRepo.signup(data: data);
    return response;
  }
}
