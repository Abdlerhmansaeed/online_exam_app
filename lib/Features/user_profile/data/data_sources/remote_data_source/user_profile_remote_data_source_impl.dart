import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/user_profile/data/data_sources/remote_data_source/user_profile_remote_data_source.dart';
import 'package:online_exam_app/Features/user_profile/data/models/change_password_request.dart';
import 'package:online_exam_app/Features/user_profile/data/models/change_password_response.dart';
import 'package:online_exam_app/Features/user_profile/data/models/edit_profile_request.dart';
import 'package:online_exam_app/Features/user_profile/data/models/edit_profile_response.dart';
import 'package:online_exam_app/Features/user_profile/data/models/get_user_profile_response.dart';
import 'package:online_exam_app/core/exceptions/failure.dart';
import 'package:online_exam_app/main.dart';
import '../../../../../core/helper/request_handler.dart';
import '../../../../../core/services/web_services.dart';



@Injectable(as: UserProfileRemoteDataSource)
class UserProfileRemoteDataSourceImpl implements UserProfileRemoteDataSource{
  final WebServices _webServices;

  UserProfileRemoteDataSourceImpl(this._webServices);

  @override
  Future<Either<Failures, ChangePasswordResponse>> changePassword(ChangePasswordRequest data) {
   var response =  _webServices.changePassword(token?? '', data);
    return RequestHandler.handle(() => response);
  }

  @override
  Future<Either<Failures, EditProfileResponse>> editUserProfile(EditProfileRequest data) {
    var response =  _webServices.editUserDetails(token?? '', data);
    return RequestHandler.handle(() => response);
  }

  @override
  Future<Either<Failures, GetUserProfileResponse>> getUserDetails() {
    var response =  _webServices.getUserDetails(token?? '');
    return RequestHandler.handle(() => response);
  }





}