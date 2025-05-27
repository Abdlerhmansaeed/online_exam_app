import 'package:online_exam_app/Features/exams/data/models/check_questions_response.dart';
import 'package:online_exam_app/core/helper/api_result.dart';

import '../../../../home/data/model/get_exams_on_subject.dart';
import '../../models/check_questions_request.dart';
import '../../models/exam_questions_response.dart';

abstract class ExamRemoteDataSource {

   Future<ApiResult<GetExamsOnSubject>> getExamsOnSubject(String subjectId);
   Future<ApiResult< ExamQuestionsResponse>> getExamsQuestions(String? examId);
   Future<ApiResult< CheckQuestionsResponse>> checkAnswers( CheckQuestionsRequest data);

}