import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/home/data/model/subjects_model.dart';
import 'package:online_exam_app/Features/home/domain/entity/all_subjects_entity.dart';
import 'package:online_exam_app/Features/home/domain/repository/data_source_contract/remote/hom_remote_data_source_cont.dart';
import 'package:online_exam_app/core/Constant/app_constant.dart';
import 'package:online_exam_app/core/Error/failure.dart';
import 'package:online_exam_app/core/services/shared_prefs.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@Injectable(as: HomRemoteDataSourceContract)
class HomeTabRemoteImpl implements HomRemoteDataSourceContract {
 
  @override
  Future<Either<Failures, List<SubjectsEntity>>> getAllSubjects() async {
    Dio dio = Dio();
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
    ));
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
}
