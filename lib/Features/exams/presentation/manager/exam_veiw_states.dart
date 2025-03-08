import 'package:equatable/equatable.dart';
import 'package:online_exam_app/core/base_states/base_states.dart';

class ExamStates extends Equatable {
  final BaseStates? examStates;
  final int? currentQuestionIndex;
  final Map<int, int>? selectedAnswers;
  final int? examDuration;
  final bool? examTimeOutState;
  final String? navigationState;

  const ExamStates(
      {this.examStates,
      this.currentQuestionIndex = 0,
      this.selectedAnswers,
      this.examDuration,
      this.examTimeOutState,
      this.navigationState});

  ExamStates copyWith(
      {BaseStates? examStates,
      int? currentQuestionIndex,
      Map<int, int>? selectedAnswers,
      int? examDuration,
      bool? examTimeOutState,
      String? navigationState}) {
    return ExamStates(
        examStates: examStates ?? this.examStates,
        currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
        selectedAnswers: selectedAnswers ?? this.selectedAnswers,
        examDuration: examDuration ?? this.examDuration,
        examTimeOutState: examTimeOutState ?? this.examTimeOutState,
        navigationState: navigationState ?? this.navigationState);
  }

  @override
  List<Object?> get props => [
        examStates,
        currentQuestionIndex,
        selectedAnswers,
        examDuration,
        examTimeOutState,
        navigationState
      ];
}
