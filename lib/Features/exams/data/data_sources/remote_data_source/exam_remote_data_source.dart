 import 'package:dartz/dartz.dart';
import 'package:online_exam_app/core/exceptions/failure.dart';

import '../../models/exam_questions_response.dart';

abstract class ExamRemoteDataSource {
   Future<Either<Failures, ExamQuestionsResponse>> getExamsQuestions(String? examId);
 }