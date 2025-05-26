import 'package:online_exam_app/Features/exams/data/models/exam_questions_response.dart';
import 'package:online_exam_app/Features/exams/data/models/exam_result.dart';
import 'package:online_exam_app/Features/exams/data/models/user_answer.dart';

abstract interface class ExamLocalDataBaseContract {
  Future<void> addExamResultToList(ExamResult examResult);
  Future<void> saveExamResultModel(ExamResult examResult);
  Future<List<ExamResult>> getAllExamResultsAsModel();
  Future<ExamResult?> getExamResultsAsModel();
  Future<void> saveUserAnswers(List<UserAnswer> userAnswers);

  Future<List<UserAnswer>> getUserAnswers();

  Future<void> saveAnswer(UserAnswer userAnswer);
  Future<void> saveUserAnswersMap(Map<String, String> answersMap);

  Future<Map<String, String>> getUserAnswersMap();
  Future<void> saveCachedApiResponse(Map<String, dynamic> response);

  Future<Map<String, dynamic>?> getCachedApiResponse();

  Future<void> saveQuestionsAsMap(List<Questions> questions);

  Future<Map<String, Map<String, dynamic>>> getQuestionsAsMap();
}
