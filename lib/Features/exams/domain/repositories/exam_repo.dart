import 'package:dartz/dartz.dart';
import 'package:online_exam_app/Features/exams/data/models/exam_questions_response.dart';

abstract class ExamRepo {
  Future<Either<String, ExamQuestionsResponse>> getExamsQuestions(String? examId);
}