import 'package:dartz/dartz.dart';
import 'package:online_exam_app/Features/exams/data/models/exam_questions_response.dart';

import '../../../home/data/model/get_exams_on_subject.dart';
import '../../data/models/check_questions_request.dart';
import '../../data/models/check_questions_response.dart';

abstract class ExamRepo {
  Future<Either<String, GetExamsOnSubject>> getExamsOnSubject(
      String subjectId);
  Future<Either<String, ExamQuestionsResponse>> getExamsQuestions(String? examId);
  Future<Either<String, CheckQuestionsResponse>> checkAnswers(CheckQuestionsRequest data);
}