import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/exams/data/data_sources/remote_data_source/exam_remote_data_source.dart';
import 'package:online_exam_app/Features/exams/data/models/check_questions_request.dart';
import 'package:online_exam_app/Features/exams/data/models/check_questions_response.dart';
import 'package:online_exam_app/Features/exams/data/models/exam_questions_response.dart';
import 'package:online_exam_app/core/exceptions/failure.dart';
import 'package:online_exam_app/core/services/web_services.dart';
import 'package:online_exam_app/main.dart';
import '../../../../../core/helper/request_handler.dart';

@Injectable(as: ExamRemoteDataSource)
class ExamRemoteDataSourceImpl implements ExamRemoteDataSource {
  final WebServices webServices;

  ExamRemoteDataSourceImpl(this.webServices);

  @override
  Future<Either<Failures, ExamQuestionsResponse>> getExamsQuestions(
      String? examId) async {
    final validExamId = examId ?? '';

    return RequestHandler.handle(() => webServices.getExamsQuestions(token?? '', validExamId));
  }

  @override
  Future<Either<Failures, CheckQuestionsResponse>> checkAnswers( CheckQuestionsRequest data) {
    return RequestHandler.handle(() => webServices.checkAnswers(token?? '', data));
  }
}

