import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/base_states/base_states.dart';
import '../../../../core/helper/handel_cubit_states.dart';
import '../../data/data_sources/local_data_source/exam_local_data_base.dart';
import '../../data/models/check_questions_request.dart';
import '../../data/models/check_questions_response.dart';
import '../../data/models/exam_questions_response.dart';
import '../../domain/use_cases/check_user_answers_use_case.dart';
import '../../domain/use_cases/exam_quetions_use_case.dart';
import 'exam_veiw_states.dart';

@injectable
class ExamViewModel extends Cubit<ExamStates> {
  ExamViewModel(this._examQuestionsUseCase, this.examLocalDataSource,
      this._checkUserAnswersUseCase)
      : super(const ExamStates());
  final ExamQuestionsUseCase _examQuestionsUseCase;
  final CheckUserAnswersUseCase _checkUserAnswersUseCase;

  PageController pageController = PageController();
  List<Questions> questions = [];
  List<ExamAnswers> answers = [];
  Timer? _timer;
  List<UserAnswers> selectedAnswers = [];

  final ExamLocalDataSource? examLocalDataSource;

  void navigateToRoute({String? routeName, BuildContext? context,Object? arguments}) {
    routeName == state.navigationState;
    Navigator.pushReplacementNamed(context!, routeName!, arguments:arguments);
    emit(state.copyWith(navigationState: routeName));
  }

  Future<void> getExamQuestions(String? examId) async {
    await handleCubitStates<ExamQuestionsResponse>(
      request: () => _examQuestionsUseCase.call(examId),
      onLoading: () => emit(state.copyWith(examStates: LoadingState())),
      onSuccess: (data) {
        questions.clear();
        answers.clear();

        data.questions?.forEach((question) {
          questions.add(question);
          if (question.answers != null) {
            answers.addAll(question.answers!);
          }
        });

        emit(state.copyWith(examStates: SuccessState(data)));
      },
      onError: (error) => emit(state.copyWith(examStates: ErrorState(error))),
    );
  }

  void goToNextQuestion(BuildContext context) {
    final nextIndex = (state.currentQuestionIndex ?? 0) + 1;
    if (nextIndex < questions.length) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      emit(state.copyWith(currentQuestionIndex: nextIndex));
    }else {
      lastQuestion();
    }
  }

  void lastQuestion() {
    checkUserAnswers();
    emit(state.copyWith(lastQuestionIndex: state.currentQuestionIndex, ));
  }


  void goToPreviousQuestion() {
    final previousIndex = (state.currentQuestionIndex ?? 0) - 1;
    if (previousIndex >= 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      emit(state.copyWith(currentQuestionIndex: previousIndex));
    }
  }

  void updateLocalSelectedAnswer(int answerIndex, int questionIndex) {
    final updatedSelectedAnswers =
        Map<int, int>.from(state.selectedAnswers ?? {});
    updatedSelectedAnswers[questionIndex] = answerIndex;
    emit(state.copyWith(selectedAnswers: updatedSelectedAnswers));
  }

  Future<void> saveUserAnswer(String questionId, String answerId) async {
    final userAnswer = UserAnswers(
      questionId: questionId,
      correct: answerId,
    );

    final updatedUserAnswers = List<UserAnswers>.from(state.userAnswers ?? []);
    final existingAnswerIndex = updatedUserAnswers
        .indexWhere((answer) => answer.questionId == questionId);
    if (existingAnswerIndex != -1) {
      updatedUserAnswers[existingAnswerIndex] = userAnswer;
    } else {
      updatedUserAnswers.add(userAnswer);
    }

    if (examLocalDataSource != null) {
      await examLocalDataSource!.saveAnswers(updatedUserAnswers);
      emit(state.copyWith(userAnswers: updatedUserAnswers));
    } else {
      print("Error: examLocalDataSource is null");
    }
  }

  void selectedUserAnswer(int answerIndex, int questionIndex, String questionId,
      String answerId) async {
    updateLocalSelectedAnswer(answerIndex, questionIndex);
    await saveUserAnswer(questionId, answerId);
  }

  Future<void> checkUserAnswers() async {
    return handleCubitStates<CheckQuestionsResponse>(
      request: () async {
        final userAnswers = await examLocalDataSource?.getAnswers();
        if (userAnswers == null || userAnswers.isEmpty) {
          throw Exception("No answers found");
        }
        List<UserAnswers> userAnswerList = userAnswers.map((answer) {
          return UserAnswers(
            questionId: answer.questionId,
            correct: answer.correct,
          );
        }).toList();

        var response = await _checkUserAnswersUseCase.call(
          CheckQuestionsRequest(answers: userAnswerList),
        );
        return response;
      },
      onSuccess: (data) {
        emit(state.copyWith(checkUserAnswersStates: SuccessState<CheckQuestionsResponse>(data)));
      },
      onError: (error) {
        emit(state.copyWith(checkUserAnswersStates: ErrorState(error)));
      },
      onLoading: () {
        emit(state.copyWith(checkUserAnswersStates: LoadingState()));
      },
    );
  }


  void timerController(double durationInMinutes) {
    const oneSec = Duration(seconds: 1);
    int examDurationInSeconds = ((durationInMinutes) * 60).toInt();
    _timer = Timer.periodic(
      oneSec,
      (timer) {
        if (examDurationInSeconds == 0) {
          timer.cancel();
          emit(state.copyWith(examDuration: 0, examTimeOutState: true));
        } else {
          examDurationInSeconds = examDurationInSeconds - 1;
          emit(state.copyWith(examDuration: examDurationInSeconds));
        }
      },
    );
  }

  void cancelTimer() {
    _timer?.cancel();
  }

  void dispose() {
    cancelTimer();
  }
}
