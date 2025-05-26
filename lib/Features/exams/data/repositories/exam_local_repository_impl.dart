import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/exams/data/data_sources/local_data_source/exam_local_data_base_contract.dart';
import '../../domain/repositories/exam_local_repository.dart';
import '../models/exam_result.dart';
import '../models/user_answer.dart';
import '../models/exam_questions_response.dart';

@LazySingleton(as: ExamLocalRepository)
class ExamLocalRepositoryImpl implements ExamLocalRepository {
  final ExamLocalDataBaseContract _localDataSource;

  ExamLocalRepositoryImpl(this._localDataSource);

  @override
  Future<Either<String, List<ExamResult>>> getAllExamResults() async {
    try {
      final results = await _localDataSource.getAllExamResultsAsModel();
      return Right(results);
    } catch (e) {
      return Left('Failed to get exam results: $e');
    }
  }

  @override
  Future<Either<String, ExamResult?>> getLatestExamResult() async {
    try {
      final result = await _localDataSource.getExamResultsAsModel();
      return Right(result);
    } catch (e) {
      return Left('Failed to get latest exam result: $e');
    }
  }

  @override
  Future<Either<String, void>> saveExamResult(ExamResult examResult) async {
    try {
      await _localDataSource.addExamResultToList(examResult);
      return const Right(null);
    } catch (e) {
      return Left('Failed to save exam result: $e');
    }
  }

  @override
  Future<Either<String, List<UserAnswer>>> getUserAnswers() async {
    try {
      final answers = await _localDataSource.getUserAnswers();
      return Right(answers);
    } catch (e) {
      return Left('Failed to get user answers: $e');
    }
  }

  @override
  Future<Either<String, Map<String, String>>> getUserAnswersMap() async {
    try {
      final answersMap = await _localDataSource.getUserAnswersMap();
      return Right(answersMap);
    } catch (e) {
      return Left('Failed to get user answers map: $e');
    }
  }

  @override
  Future<Either<String, void>> saveUserAnswer(UserAnswer userAnswer) async {
    try {
      await _localDataSource.saveAnswer(userAnswer);
      return const Right(null);
    } catch (e) {
      return Left('Failed to save user answer: $e');
    }
  }

  @override
  Future<Either<String, void>> saveUserAnswersMap(
      Map<String, String> answersMap) async {
    try {
      await _localDataSource.saveUserAnswersMap(answersMap);
      return const Right(null);
    } catch (e) {
      return Left('Failed to save user answers map: $e');
    }
  }

  @override
  Future<Either<String, Map<String, Map<String, dynamic>>>>
      getQuestionsAsMap() async {
    try {
      final questionsMap = await _localDataSource.getQuestionsAsMap();
      return Right(questionsMap);
    } catch (e) {
      return Left('Failed to get questions map: $e');
    }
  }

  @override
  Future<Either<String, void>> saveQuestionsAsMap(
      List<Questions> questions) async {
    try {
      await _localDataSource.saveQuestionsAsMap(questions);
      return const Right(null);
    } catch (e) {
      return Left('Failed to save questions map: $e');
    }
  }

  @override
  Future<Either<String, Map<String, dynamic>?>> getCachedApiResponse() async {
    try {
      final response = await _localDataSource.getCachedApiResponse();
      return Right(response);
    } catch (e) {
      return Left('Failed to get cached API response: $e');
    }
  }

  @override
  Future<Either<String, void>> saveCachedApiResponse(
      Map<String, dynamic> response) async {
    try {
      await _localDataSource.saveCachedApiResponse(response);
      return const Right(null);
    } catch (e) {
      return Left('Failed to save cached API response: $e');
    }
  }
}
