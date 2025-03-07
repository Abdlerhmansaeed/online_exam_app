import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/home/data/model/exams_on_subject_model.dart';
import 'package:online_exam_app/Features/home/data/model/subjects_model.dart';
import 'package:online_exam_app/Features/profile/data/models/change_password_request.dart';
import 'package:online_exam_app/Features/profile/data/models/edit_profile_request.dart';
import 'package:online_exam_app/core/Constant/app_constant.dart';
import 'package:online_exam_app/core/Error/failure.dart';
import 'package:online_exam_app/core/di/di.dart';
// import 'package:online_exam_app/core/services/network_srevices.dart';
import 'package:online_exam_app/core/services/shared_prefs.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@singleton
class ApiManager {
  // final networkServices = getIt<NetworkServices>();
  final dio = Dio();

  void prettyLogger() {
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );
  }

  Future<Either<Failures, List<SubjectsModel>>> getAllSubjects() async {
    prettyLogger();
    final response = await dio.get(AppConstant.allSubjectsEndPoint,
        options: Options(
          headers: {"token": await SharedPrefs().getString('token')},
        ));
    if (response.statusCode == 200) {
      final subjects = List<SubjectsModel>.from(
          (response.data["subjects"] as List)
              .map((e) => SubjectsModel.fromJson(e)));

      return Right(subjects);
    } else {
      return Left(ServerFailure(errorMessage: response.statusMessage!));
    }
  }

  Future<Either<Failures, List<ExamsOnSubjectModel>>> getExamsOnSubject(
      String subjectId) async {
    prettyLogger();
    final response = await dio.get(AppConstant.subjectExamsEndPoint(subjectId),
        options: Options(
            headers: {"token": await SharedPrefs().getString('token')}));
    if (response.statusCode == 200) {
      final exams = List<ExamsOnSubjectModel>.from(
          (response.data["exams"] as List)
              .map((e) => ExamsOnSubjectModel.fromJson(e)));
      return Right(exams);
    } else {
      return Left(ServerFailure(errorMessage: response.statusMessage!));
    }
  }

  Future<Response> login({required String email, required String password}) {
    return dio.post(
      AppConstant.signInEndPoint,
      data: {"email": email, "password": password},
    );
  }

  Future<Response> signup({
    required String email,
    required String password,
    required String rePassword,
    required String userName,
    required String firstName,
    required String lastName,
    required String phoneNumber,
  }) {
    return dio.post(
      AppConstant.signupEndPoint,
      data: {
        "username": userName,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password,
        "rePassword": rePassword,
        "phone": phoneNumber,
      },
    );
  }

  Future<Response> forgetPasswordEmailVerify({required String email}) {
    return dio.post(
      AppConstant.forgotPasswordEndPoint,
      data: {"email": email},
    );
  }

  Future<Response> resetCodeVerify({required String resetCode}) {
    return dio.post(
      AppConstant.verifyResetCodeEndPoint,
      data: {"resetCode": resetCode},
    );
  }

  Future<Response> resetPassword(
      {required String email, required String password}) {
    return dio.put(
      AppConstant.resetPasswordEndPoint,
      data: {
        "email": email,
        "newPassword": password,
      },
    );
  }

  Future<Response> getUserProfile() async {
    return dio.get(AppConstant.getUserProfileEndPoint,
        options: Options(
          headers: {"token": await SharedPrefs().getString('token')},
        ));
  }

  Future<Response> editProfile(EditProfileRequest editProfile) async {
    return dio.put(AppConstant.editProfileEndPoint,
        data: {
          "username": editProfile.userName,
          "firstName": editProfile.firstName,
          "lastName": editProfile.lastName,
          "email": editProfile.email,
          "phone": editProfile.phone,
        },
        options: Options(
          headers: {"token": await SharedPrefs().getString('token')},
        ));
  }

  Future<Response> changePassword(ChangePasswordRequest changePassword) async {
    return dio.post(AppConstant.changePasswordEndPoint,
        options: Options(
          headers: {"token": await SharedPrefs().getString('token')},
        ),
        data: {
          "oldPassword": changePassword.oldPassword,
          "password": changePassword.password,
          "rePassword": changePassword.rePassword,
        });
  }
}
