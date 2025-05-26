import 'package:dartz/dartz.dart';
import '../../data/models/exam_result.dart';
import '../../data/models/user_answer.dart';
import '../../data/models/exam_questions_response.dart';

abstract class ExamLocalRepository {
  // Exam Results Methods
  Future<Either<String, List<ExamResult>>> getAllExamResults();
  Future<Either<String, ExamResult?>> getLatestExamResult();
  Future<Either<String, void>> saveExamResult(ExamResult examResult);

  // User Answers Methods
  Future<Either<String, List<UserAnswer>>> getUserAnswers();
  Future<Either<String, Map<String, String>>> getUserAnswersMap();
  Future<Either<String, void>> saveUserAnswer(UserAnswer userAnswer);
  Future<Either<String, void>> saveUserAnswersMap(
      Map<String, String> answersMap);

  // Questions Methods
  Future<Either<String, Map<String, Map<String, dynamic>>>> getQuestionsAsMap();
  Future<Either<String, void>> saveQuestionsAsMap(List<Questions> questions);

  // Cache Methods
  Future<Either<String, Map<String, dynamic>?>> getCachedApiResponse();
  Future<Either<String, void>> saveCachedApiResponse(
      Map<String, dynamic> response);
}
