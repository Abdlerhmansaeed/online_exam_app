import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/exams/data/models/answer_option.dart';
import 'package:online_exam_app/Features/exams/data/models/exam_result.dart';
import 'package:online_exam_app/Features/exams/data/models/question_result.dart';
import 'package:online_exam_app/Features/exams/data/models/user_answer.dart';
import 'package:online_exam_app/core/base_states/app_states.dart';
import 'package:online_exam_app/core/helper/handle_cubit_states.dart';
import '../../../home/data/model/get_exams_on_subject.dart';
import '../../domain/repositories/exam_local_repository.dart'; // Import abstraction
import '../../data/models/check_questions_request.dart';
import '../../data/models/check_questions_response.dart';
import '../../data/models/exam_questions_response.dart';
import '../../domain/use_cases/check_user_answers_use_case.dart';
import '../../domain/use_cases/exam_quetions_use_case.dart';
import '../../domain/use_cases/get_exams_on_subject_use_case.dart';
import 'exam_states.dart';

@injectable
class ExamViewModel extends Cubit<ExamStates> {
  ExamViewModel(
    this._examQuestionsUseCase,
    this._examLocalRepository, // Use repository instead of data source
    this._checkUserAnswersUseCase,
    this._getExamsOnSubjectUseCase,
  ) : super(const ExamStates());

  final ExamQuestionsUseCase _examQuestionsUseCase;
  final CheckUserAnswersUseCase _checkUserAnswersUseCase;
  final GetExamsOnSubjectUseCase _getExamsOnSubjectUseCase;
  final ExamLocalRepository _examLocalRepository; // Use abstraction

  PageController pageController = PageController();
  List<Questions> questions = [];
  List<ExamAnswers> answers = [];
  Timer? _timer;
  List<UserAnswers> selectedAnswers = [];
  bool isExamining = false;

  // Add these properties
  final ValueNotifier<int> examDurationNotifier = ValueNotifier(0);
  final ValueNotifier<bool> isDangerTimeNotifier = ValueNotifier(false);
  final ValueNotifier<bool> isTimeoutNotifier = ValueNotifier(false);

  // New property to store current exam details when questions are fetched
  Exams? currentExamDetails;

  // Add properties to store exam metadata
  String? currentExamId;
  String? currentExamTitle;
  String? currentSubjectName;
  int? currentNumberOfQuestions;
  int? currentDuration;

  void dispose() {
    cancelTimer();
    pageController.dispose();
  }

  void navigateToRoute({
    required String routeName,
    required BuildContext context,
    Object? arguments,
  }) {
    if (routeName == state.navigationState) return;

    Navigator.pushReplacementNamed(context, routeName, arguments: arguments);
    emit(state.copyWith(navigationState: routeName));
  }

  Future<void> getExamsOnSubject(String subjectId) async {
    return handleCubitStates<GetExamsOnSubject>(
      request: () => _getExamsOnSubjectUseCase.invoke(subjectId),
      emit: (newState) {
        emit(state.copyWith(
          examOnSubjectStates: newState,
        ));
      },
    );
  }

  void setCurrentExamMetadata({
    required String examId,
    required String examTitle,
    required String subjectName,
    required int numberOfQuestions,
    required int duration,
  }) {
    currentExamId = examId;
    currentExamTitle = examTitle;
    currentSubjectName = subjectName;
    currentNumberOfQuestions = numberOfQuestions;
    currentDuration = duration;
  }

  Future<void> getExamQuestions(String? examId) async {
    await handleCubitStates<ExamQuestionsResponse>(
      request: () => _examQuestionsUseCase.call(examId),
      emit: (newState) => emit(state.copyWith(examStates: newState)),
      onSuccess: (data) async {
        isExamining = true;
        questions = data?.questions ?? [];
        answers = questions
            .expand((q) => q.answers ?? [])
            .map((e) => e as ExamAnswers)
            .toList();

        // If numberOfQuestions wasn't set or is wrong, update it from actual questions
        if (currentNumberOfQuestions == null || currentNumberOfQuestions == 0) {
          currentNumberOfQuestions = questions.length;
        }

        await _saveQuestionsWithDetails(questions);
        emit(state.copyWith(examStates: SuccessState(data)));
      },
    );
  }

  Future<void> _saveQuestionsWithDetails(List<Questions> questions) async {
    try {
      final result = await _examLocalRepository.saveQuestionsAsMap(questions);
      result.fold(
        (error) => debugPrint('🔴 Error saving questions: $error'),
        (_) => debugPrint('✅ Questions saved successfully'),
      );
    } catch (e) {
      debugPrint('🔴 Error in _saveQuestionsWithDetails: $e');
    }
  }

  Future<Map<String, Map<String, dynamic>>> getStoredQuestionsDetails() async {
    try {
      final result = await _examLocalRepository.getQuestionsAsMap();
      return result.fold(
        (error) {
          return <String, Map<String, dynamic>>{};
        },
        (questionsMap) => questionsMap,
      );
    } catch (e) {
      return <String, Map<String, dynamic>>{};
    }
  }

  void goToNextQuestion(BuildContext context) {
    final nextIndex = (state.currentQuestionIndex)! + 1;
    if (nextIndex < questions.length) {
      pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      emit(state.copyWith(currentQuestionIndex: nextIndex));
    } else {
      emit(state.copyWith(isLastQuestion: true));
    }
  }

  void goToPreviousQuestion() {
    final previousIndex = (state.currentQuestionIndex)! - 1;
    if (previousIndex >= 0) {
      pageController.previousPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      emit(state.copyWith(currentQuestionIndex: previousIndex));
    }
  }

  Future<void> checkUserAnswers() async {
    try {
      emit(state.copyWith(
        checkUserAnswersStates: const LoadingState(),
      ));

      List<UserAnswers> userAnswersList = [];
      Map<String, String> answersMap = {};

      state.selectedAnswers.forEach((questionIndex, answerIndex) {
        final question = questions[questionIndex];
        final selectedAnswer = question.answers?[answerIndex];

        if (question.Id != null && selectedAnswer?.key != null) {
          answersMap[question.Id!] = selectedAnswer!.key!;
        }
      });

      // Use repository instead of direct data source
      final saveResult =
          await _examLocalRepository.saveUserAnswersMap(answersMap);
      saveResult.fold(
        (error) => debugPrint('Error saving user answers: $error'),
        (_) => debugPrint('?>>?>? User answers saved successfully'),
      );

      answersMap.forEach((questionId, answerKey) {
        userAnswersList.add(
          UserAnswers(questionId: questionId, correct: answerKey),
        );
      });

      final result = await _checkUserAnswersUseCase.call(
        CheckQuestionsRequest(
            answers: userAnswersList, time: state.examDuration ?? 0),
      );

      result.when(
        failure: (message) {
          emit(state.copyWith(
            checkUserAnswersStates: ErrorState(message),
          ));
        },
        success: (data) {
          _saveExamResults(data, answersMap);

          emit(state.copyWith(
            checkUserAnswersStates: SuccessState(data),
            userAnswers: userAnswersList,
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        checkUserAnswersStates: ErrorState(e.toString()),
      ));
    }
  }

  Future<void> _saveExamResults(CheckQuestionsResponse apiResponse,
      Map<String, String> userAnswers) async {
    try {
      final questionsDetails = await getStoredQuestionsDetails();

      List<QuestionResult> correctQuestionsList = [];
      List<QuestionResult> wrongQuestionsList = [];

      // Process correct questions
      if (apiResponse.correctQuestions != null) {
        for (var correctQMap in apiResponse.correctQuestions!) {
          if (correctQMap is Map<String, dynamic>) {
            final questionId = correctQMap['QID']?.toString() ?? '';
            final questionText = correctQMap['Question']?.toString() ?? '';
            final correctAnswerKey =
                correctQMap['correctAnswer']?.toString() ?? '';
            final questionDetail = questionsDetails[questionId];

            if (questionDetail != null && questionId.isNotEmpty) {
              correctQuestionsList.add(QuestionResult(
                questionId: questionId,
                questionText: questionText,
                correctAnswer: correctAnswerKey,
                userAnswer: userAnswers[questionId] ?? correctAnswerKey,
                allAnswers: (questionDetail['answers'] as List<dynamic>?)
                        ?.map((ans) =>
                            AnswerOption.fromJson(ans as Map<String, dynamic>))
                        .toList() ??
                    [],
              ));
            }
          }
        }
      }

      // Process wrong questions
      if (apiResponse.WrongQuestions != null) {
        for (var wrongQMap in apiResponse.WrongQuestions!) {
          if (wrongQMap is Map<String, dynamic>) {
            final questionId = wrongQMap['QID']?.toString() ?? '';
            final questionText = wrongQMap['Question']?.toString() ?? '';
            final correctAnswerKey =
                wrongQMap['correctAnswer']?.toString() ?? '';
            final userIncorrectAnswerKey =
                wrongQMap['inCorrectAnswer']?.toString() ?? '';
            final questionDetail = questionsDetails[questionId];

            if (questionDetail != null && questionId.isNotEmpty) {
              wrongQuestionsList.add(QuestionResult(
                questionId: questionId,
                questionText: questionText,
                correctAnswer: correctAnswerKey,
                userAnswer: userIncorrectAnswerKey,
                allAnswers: (questionDetail['answers'] as List<dynamic>?)
                        ?.map((ans) =>
                            AnswerOption.fromJson(ans as Map<String, dynamic>))
                        .toList() ??
                    [],
              ));
            }
          }
        }
      }

      final finalExamId = currentExamId ?? "unknown_exam_id";
      final finalExamTitle = currentExamTitle ?? "Unknown Exam";
      final finalSubjectName = currentSubjectName ?? "Unknown Subject";
      final finalNumberOfQuestions = currentNumberOfQuestions ??
          (correctQuestionsList.length + wrongQuestionsList.length);
      final finalDuration = currentDuration ?? 0;

      final examResultToSave = ExamResult(
        examId: finalExamId,
        examTitle: finalExamTitle,
        subjectName: finalSubjectName,
        numberOfQuestions: finalNumberOfQuestions,
        duration: finalDuration,
        score: {
          'correct': apiResponse.correct ?? 0,
          'wrong': apiResponse.wrong ?? 0,
          'total': apiResponse.total ?? '0%',
          'message': apiResponse.message ?? 'Unknown',
        },
        correctQuestions: correctQuestionsList,
        wrongQuestions: wrongQuestionsList,
        timestamp: DateTime.now().millisecondsSinceEpoch,
      );

      final result =
          await _examLocalRepository.saveExamResult(examResultToSave);
      result.fold(
        (error) => debugPrint('🔴 Error saving exam result: $error'),
        (_) => debugPrint(
            "✅ Exam result saved successfully: $finalExamTitle - $finalSubjectName"),
      );
    } catch (e) {
      debugPrint('🔴 Error saving exam results: $e');
    }
  }

  void timerController(double durationInMinutes) {
    int examDurationInSeconds = (durationInMinutes * 60).round();
    examDurationNotifier.value = examDurationInSeconds;

    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      if (examDurationInSeconds == 0) {
        timer.cancel();
        isTimeoutNotifier.value = true;
        emit(state.copyWith(examTimeOutState: true));
      } else {
        examDurationInSeconds--;
        examDurationNotifier.value = examDurationInSeconds;
        isDangerTimeNotifier.value = examDurationInSeconds <= 900;
      }
    });
  }

  void cancelTimer() {
    _timer?.cancel();
  }

  void selectAnswer(int questionIndex, int answerIndex) async {
    final updatedSelectedAnswers = Map<int, int>.from(state.selectedAnswers);
    updatedSelectedAnswers[questionIndex] = answerIndex;
    emit(state.copyWith(selectedAnswers: updatedSelectedAnswers));

    final question = questions[questionIndex];
    final selectedAnswer = question.answers?[answerIndex];

    if (selectedAnswer != null && question.Id != null) {
      final userAnswer = UserAnswer(
          questionId: question.Id!, answerId: selectedAnswer.key ?? '');

      final result = await _examLocalRepository.saveUserAnswer(userAnswer);
      result.fold(
        (error) => debugPrint('🔴 Error saving user answer: $error'),
        (_) => debugPrint('✅ User answer saved successfully'),
      );
    }
  }

  @override
  Future<void> close() {
    examDurationNotifier.dispose();
    isDangerTimeNotifier.dispose();
    isTimeoutNotifier.dispose();
    cancelTimer();
    return super.close();
  }
}
