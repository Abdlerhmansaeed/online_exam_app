part of 'user_view_model_cubit.dart';

abstract class UserViewModelState extends Equatable {
  const UserViewModelState();

  @override
  List<Object?> get props => [];
}

class UserViewModelInitial extends UserViewModelState {}

class UserViewModelLoading extends UserViewModelState {}

class UserViewModelSuccess extends UserViewModelState {}

class UserViewModelError extends UserViewModelState {
  final String errorMessage;

  const UserViewModelError({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

// Exam Results States
class ExamResultsLoading extends UserViewModelState {}

class ExamResultsEmpty extends UserViewModelState {}

class ExamResultsSuccess extends UserViewModelState {
  final List<ExamResult> examResults; 
  const ExamResultsSuccess({required this.examResults});
  @override
  List<Object?> get props => [examResults];
}
class ExamResultsError extends UserViewModelState {
  final String errorMessage;
  const ExamResultsError({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}
// Exam Details States
class ExamDetailsLoading extends UserViewModelState {}

class ExamDetailsSuccess extends UserViewModelState {
  final Map<String, Map<String, dynamic>> questionsMap;
  final Map<String, String> userAnswersMap;
  final List<UserAnswer> userAnswers;
  final ExamResult? examResult;
  final String examId;

  const ExamDetailsSuccess({
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

class ExamDetailsError extends UserViewModelState {
  final String errorMessage;

  const ExamDetailsError({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

// Exam Answers States
class ExamAnswersLoading extends UserViewModelState {}

class ExamAnswersSuccess extends UserViewModelState {
  final Exams exam;
  final Map<String, Map<String, dynamic>> questionsMap;
  final Map<String, String> userAnswersMap;
  final List<UserAnswer> userAnswers;

  const ExamAnswersSuccess({
    required this.exam,
    required this.questionsMap,
    required this.userAnswersMap,
    required this.userAnswers,
  });

  @override
  List<Object?> get props => [exam, questionsMap, userAnswersMap, userAnswers];
}

class ExamAnswersError extends UserViewModelState {
  final String errorMessage;

  const ExamAnswersError({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
