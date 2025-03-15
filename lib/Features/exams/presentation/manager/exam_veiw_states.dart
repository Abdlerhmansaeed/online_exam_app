import 'package:equatable/equatable.dart';
import 'package:online_exam_app/Features/exams/data/models/check_questions_request.dart';
import 'package:online_exam_app/core/base_states/base_states.dart';

class ExamStates extends Equatable {
  final BaseStates? examStates;
  final int? currentQuestionIndex;
  final Map<int, int>? selectedAnswers;
  final int? examDuration;
  final bool? examTimeOutState;
  final String? navigationState;
  final List<UserAnswers>? userAnswers;
  final BaseStates? checkUserAnswersStates;
  final bool ? isLastQuestion;

  const ExamStates({
    this.examStates,
    this.isLastQuestion,
    this.currentQuestionIndex = 0,
    this.selectedAnswers,
    this.examDuration,
    this.examTimeOutState,
    this.navigationState,
    this.userAnswers,
    this.checkUserAnswersStates,
  });

  ExamStates copyWith({
    final BaseStates? examStates,
    final int? currentQuestionIndex,
    final Map<int, int>? selectedAnswers,
    final int? examDuration,
    final bool? examTimeOutState,
    final bool? isLastQuestion,
    final String? navigationState,
    final List<UserAnswers>? userAnswers,
    final BaseStates? checkUserAnswersStates,
  }) {
    return ExamStates(
        examStates: examStates ?? this.examStates,
        currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
        selectedAnswers: selectedAnswers ?? this.selectedAnswers,
        isLastQuestion: isLastQuestion ?? this.isLastQuestion,
        examDuration: examDuration ?? this.examDuration,
        examTimeOutState: examTimeOutState ?? this.examTimeOutState,
        userAnswers: userAnswers ?? this.userAnswers,
        checkUserAnswersStates:
            checkUserAnswersStates ?? this.checkUserAnswersStates,
        navigationState: navigationState ?? this.navigationState);
  }

  @override
  List<Object?> get props => [
        examStates,
        currentQuestionIndex,
        selectedAnswers,
        examDuration,
        examTimeOutState,
        isLastQuestion,
        checkUserAnswersStates,
        userAnswers,
        navigationState
      ];
}
