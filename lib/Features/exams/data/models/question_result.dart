import 'package:equatable/equatable.dart';
import 'answer_option.dart';

class QuestionResult extends Equatable {
  final String questionId;
  final String questionText;
  final String correctAnswer;
  final String? userAnswer;
  final List<AnswerOption> allAnswers;

  const QuestionResult({
    required this.questionId,
    required this.questionText,
    required this.correctAnswer,
    this.userAnswer,
    required this.allAnswers,
  });

  factory QuestionResult.fromJson(Map<String, dynamic> json) {
    // Flexible extraction of data with fallbacks
    final questionId = json['questionId'] ?? json['_id'] ?? '';

    final questionText = json['questionText'] ??
        json['Question'] ??
        json['question'] ??
        'No question text';

    final correctAnswer = json['correctAnswer'] ??
        json['CorrectAnswer'] ??
        json['correct_answer'] ??
        '';

    final userAnswer =
        json['userAnswer'] ?? json['UserAnswer'] ?? json['user_answer'];

    // Extract answer options
    List<AnswerOption> allAnswers = [];
    final answersData = json['allAnswers'] ?? json['answers'] ?? [];
    if (answersData is List) {
      for (var a in answersData) {
        if (a is Map) {
          allAnswers.add(AnswerOption.fromJson(Map<String, dynamic>.from(a)));
        }
      }
    }

    return QuestionResult(
      questionId: questionId,
      questionText: questionText,
      correctAnswer: correctAnswer,
      userAnswer: userAnswer,
      allAnswers: allAnswers,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questionId': questionId,
      'questionText': questionText,
      'correctAnswer': correctAnswer,
      'userAnswer': userAnswer,
      'allAnswers': allAnswers.map((a) => a.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props =>
      [questionId, questionText, correctAnswer, userAnswer, allAnswers];
}
