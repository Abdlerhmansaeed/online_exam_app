import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/auth/data/data_sources/auth_data_source.dart';
import 'package:online_exam_app/core/di/di.dart';
import 'package:online_exam_app/core/services/api_manager.dart';


@Injectable(as: AuthDataSource)
class AuthDataSourceImp implements AuthDataSource {
 final apiManager = getIt<ApiManager>();
  @override
  Future<Response> forgetPasswordEmailVerify({required String email}) async {
   final response = await apiManager.forgetPasswordEmailVerify(email: email);
   return response;
   
  }
  
  @override
  Future<Response> login({required String email, required String password}) async {
   return await apiManager.login(email: email, password: password);
  }
  
  @override
  Future<Response> resetCodeVerify({required String resetCode}) async {
   return await apiManager.resetCodeVerify(resetCode: resetCode);
  }
  
  @override
  Future<Response> resetPassword({required String email, required String password}) async {
   return await apiManager.resetPassword(email: email, password: password);
  }
  
  @override
  Future<Response> signup({required String email, required String password, required String rePassword, required String userName, required String firstName, required String lastName, required String phoneNumber}) async {
   return await apiManager.signup(email: email, password: password, rePassword: rePassword, userName: userName, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber);
  }

  

}
