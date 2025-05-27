import 'package:equatable/equatable.dart';

import 'package:online_exam_app/Features/exams/data/models/check_questions_request.dart';
import 'package:online_exam_app/core/base_states/app_states.dart';

class ExamStates extends Equatable {
  final AppStates? examStates;
  final int? currentQuestionIndex;
  final Map<int, int> selectedAnswers;
  final int? examDuration;
  final bool? examTimeOutState;
  final bool? isLastQuestion;
  final bool? isDangerTime;
  final bool? isInExam;
  final AppStates? examOnSubjectStates;
  final AppStates? checkUserAnswersStates;
  final List<UserAnswers>? userAnswers;
  final String? navigationState;
  const ExamStates({
    this.examStates,
    this.selectedAnswers = const {},
    this.currentQuestionIndex = 0,
    this.examDuration,
    this.examTimeOutState,
    this.isLastQuestion,
    this.isDangerTime,
    this.isInExam,
    this.examOnSubjectStates,
    this.checkUserAnswersStates,
    this.userAnswers,
    this.navigationState,
  });

  ExamStates copyWith({
    AppStates? examStates,
    int? currentQuestionIndex,
    int? examDuration,
    bool? examTimeOutState,
    bool? isLastQuestion,
    bool? isDangerTime,
    Map<int, int>? selectedAnswers,
    bool? isInExam,
    AppStates? examOnSubjectStates,
    AppStates? checkUserAnswersStates,
    List<UserAnswers>? userAnswers,
    String? navigationState,
  }) {
    return ExamStates(
      examStates: examStates ?? this.examStates,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      examDuration: examDuration ?? this.examDuration,
      examTimeOutState: examTimeOutState ?? this.examTimeOutState,
      isLastQuestion: isLastQuestion ?? this.isLastQuestion,
      isDangerTime: isDangerTime ?? this.isDangerTime,
      isInExam: isInExam ?? this.isInExam,
      selectedAnswers: selectedAnswers ?? this.selectedAnswers,
      examOnSubjectStates: examOnSubjectStates ?? this.examOnSubjectStates,
      checkUserAnswersStates:
          checkUserAnswersStates ?? this.checkUserAnswersStates,
      userAnswers: userAnswers ?? this.userAnswers,
      navigationState: navigationState ?? this.navigationState,
    );
  }

  @override
  List<Object?> get props => [
        examStates,
        currentQuestionIndex,
        selectedAnswers,
        examDuration,
        examTimeOutState,
        isLastQuestion,
        isDangerTime,
        isInExam,
        examOnSubjectStates,
        checkUserAnswersStates,
        userAnswers,
        navigationState,
      ];
}
