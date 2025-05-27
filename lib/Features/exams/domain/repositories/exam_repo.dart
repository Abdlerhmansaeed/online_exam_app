import 'package:dartz/dartz.dart';
import 'package:online_exam_app/Features/exams/data/models/exam_questions_response.dart';
import 'package:online_exam_app/core/helper/api_result.dart';

import '../../../home/data/model/get_exams_on_subject.dart';
import '../../data/models/check_questions_request.dart';
import '../../data/models/check_questions_response.dart';

abstract class ExamRepo {
  Future<ApiResult< GetExamsOnSubject>> getExamsOnSubject(
      String subjectId);
  Future<ApiResult< ExamQuestionsResponse>> getExamsQuestions(String? examId);
  Future<ApiResult< CheckQuestionsResponse>> checkAnswers(CheckQuestionsRequest data);
}