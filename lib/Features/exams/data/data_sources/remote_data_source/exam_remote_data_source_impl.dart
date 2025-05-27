import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/exams/data/data_sources/remote_data_source/exam_remote_data_source.dart';
import 'package:online_exam_app/Features/exams/data/models/check_questions_request.dart';
import 'package:online_exam_app/Features/exams/data/models/check_questions_response.dart';
import 'package:online_exam_app/Features/exams/data/models/exam_questions_response.dart';
import 'package:online_exam_app/Features/home/data/model/get_exams_on_subject.dart';
import 'package:online_exam_app/core/helper/api_result.dart';
import 'package:online_exam_app/core/helper/retrofit_handler.dart';
import 'package:online_exam_app/core/services/web_services.dart';

@Injectable(as: ExamRemoteDataSource)
class ExamRemoteDataSourceImpl implements ExamRemoteDataSource {
  final WebServices webServices;

  ExamRemoteDataSourceImpl(this.webServices);

  @override
  Future<ApiResult<ExamQuestionsResponse>> getExamsQuestions(
      String? examId) async {
    final validExamId = examId ?? '';

    return RetrofitHandler.handle(() => webServices.getExamsQuestions(validExamId));
  }

  @override
  Future<ApiResult< CheckQuestionsResponse>> checkAnswers( CheckQuestionsRequest data) {
    return RetrofitHandler.handle(() => webServices.checkAnswers( data));
  }


  @override
  Future<ApiResult< GetExamsOnSubject>> getExamsOnSubject(
      String subjectId) async {
    return RetrofitHandler.handle(() =>
        webServices.getExamsOnSubject(subjectId,));

  }
}

