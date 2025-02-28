import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/home/data/model/subjects_model.dart';
import 'package:online_exam_app/Features/home/domain/entity/all_subjects_entity.dart';
import 'package:online_exam_app/core/Constant/app_constant.dart';
import 'package:online_exam_app/core/Error/failure.dart';
import 'package:online_exam_app/core/di/di.dart';
import 'package:online_exam_app/core/services/network_srevices.dart';
import 'package:online_exam_app/core/services/shared_prefs.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@singleton
class ApiManager {
  final networkServices = getIt<NetworkServices>();
  final dio = Dio();
  Future<Either<Failures, List<SubjectsEntity>>> getAllSubjects() async {
    
    dio.interceptors.add(
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
    ),);
    final response = await dio.get(AppConstant.allSubjectsEndPoint,
        options: Options(
          headers: {
            "token": await SharedPrefs().getString('token')
          },
        ));
    if (response.statusCode == 200) {
      final allSubjectsResponse = AllSubjectsResponse.fromJson(response.data);
      List<SubjectsEntity> subjects = allSubjectsResponse.subjects
              ?.map((subject) => subject.toSubjectEntity())
              .toList() ??
          [];

      return Right(subjects);
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

  
  Future<Response> resetPassword({required String email, required String password}) {
    return dio.put(
      AppConstant.resetPasswordEndPoint,
      data: {
        "email": email,
        "newPassword": password,
      },
    );
  }
  // Future<Response> logout() {
  //   _networkServices.dio.get()
  // }

}