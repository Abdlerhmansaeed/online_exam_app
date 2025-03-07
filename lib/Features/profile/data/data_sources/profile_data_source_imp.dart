import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/auth/data/data_sources/auth_data_source.dart';
import 'package:online_exam_app/Features/profile/data/data_sources/profile_data_source.dart';
import 'package:online_exam_app/Features/profile/data/models/change_password_request.dart';
import 'package:online_exam_app/Features/profile/data/models/edit_profile_request.dart';
import 'package:online_exam_app/Features/profile/data/models/edit_profile_response.dart';
import 'package:online_exam_app/core/Constant/app_constant.dart';
import 'package:online_exam_app/core/di/di.dart';
import 'package:online_exam_app/core/services/api_manager.dart';
import 'package:online_exam_app/core/services/shared_prefs.dart';


@Injectable(as: ProfileDataSource)
class ProfileDataSourceImp implements ProfileDataSource {
  final apiManager = getIt<ApiManager>();

  @override
  Future<Response> getUserProfile() async{
    return apiManager.getUserProfile();
  }
  @override
  Future<Response> editProfile(EditProfileRequest editProfile)async {
    return await apiManager.editProfile(editProfile);
  }

  @override
  Future<Response> changePassword(ChangePasswordRequest changePassword) async{
    return await apiManager.changePassword(changePassword);
  }




}
