import 'package:equatable/equatable.dart';

class UserAnswer extends Equatable {
  final String questionId;
  final String answerId;
  final bool? isCorrect;

  const UserAnswer({
    required this.questionId,
    required this.answerId,
    this.isCorrect,
  });

  factory UserAnswer.fromJson(Map<String, dynamic> json) {
    return UserAnswer(
      questionId: json['questionId'] ?? '',
      answerId: json['correct'] ?? json['answerId'] ?? '',
      isCorrect: json['isCorrect'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questionId': questionId,
      'answerId': answerId,
      if (isCorrect != null) 'isCorrect': isCorrect,
    };
  }

  @override
  List<Object?> get props => [questionId, answerId, isCorrect];
}
