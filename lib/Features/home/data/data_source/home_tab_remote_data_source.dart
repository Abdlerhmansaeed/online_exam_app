import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/home/data/model/get_exams_on_subject.dart';
import 'package:online_exam_app/Features/home/data/model/get_subjects_response.dart';
import 'package:online_exam_app/Features/home/domain/repository/data_source_contract/remote/home_remote_data_source_cont.dart';
import 'package:online_exam_app/core/exceptions/failure.dart';
import 'package:online_exam_app/core/di/di.dart';
import 'package:online_exam_app/core/services/web_services.dart';
import 'package:online_exam_app/main.dart';
import '../../../../core/helper/request_handler.dart';

@Injectable(as: HomRemoteDataSourceContract)
class HomeTabRemoteImpl implements HomRemoteDataSourceContract {
  final webServices = getIt<WebServices>();

  @override
  Future<Either<Failures, GetSubjectsResponse>> getAllSubjects() async {
    return RequestHandler.handle(() => webServices.getAllSubjects(token ?? ''));
  }

  @override
  Future<Either<Failures, GetExamsOnSubject>> getExamsOnSubject(
      String subjectId) async {
    return RequestHandler.handle(() =>
        webServices.getExamsOnSubject(subjectId, token ?? ''));

  }
}