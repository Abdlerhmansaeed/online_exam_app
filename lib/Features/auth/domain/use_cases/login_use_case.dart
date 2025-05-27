import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/auth/domain/repositories/auth_repo.dart';
import 'package:online_exam_app/core/helper/api_result.dart';
import '../../data/models/request_model/login_request.dart';
import '../entities/user_entiti.dart';

@injectable
class LoginUseCase {
  final AuthRepo _authRepo;

  LoginUseCase(this._authRepo);

  Future<ApiResult<UserEntity>> call({required LoginRequest data}) async {
    var response = await _authRepo.login(data: data);

    return response;
  }
}
