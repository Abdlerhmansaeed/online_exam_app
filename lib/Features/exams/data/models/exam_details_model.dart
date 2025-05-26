import 'package:equatable/equatable.dart';
import 'package:online_exam_app/Features/exams/data/models/user_answer.dart';
import 'exam_result.dart';

class ExamDetailsModel extends Equatable {
  final Map<String, Map<String, dynamic>> questionsMap;
  final Map<String, String> userAnswersMap;
  final List<UserAnswer> userAnswers;
  final ExamResult? examResult;
  final String examId;

  const ExamDetailsModel({
    required this.questionsMap,
    required this.userAnswersMap,
    required this.userAnswers,
    this.examResult,
    required this.examId,
  });

  @override
  List<Object?> get props =>
      [questionsMap, userAnswersMap, userAnswers, examResult, examId];
}
