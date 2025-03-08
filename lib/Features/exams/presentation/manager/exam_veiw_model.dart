import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/exams/data/models/exam_questions_response.dart';
import 'package:online_exam_app/Features/exams/domain/use_cases/exam_quetions_use_case.dart';
import 'package:online_exam_app/Features/exams/presentation/manager/exam_veiw_states.dart';
import 'package:online_exam_app/core/base_states/base_states.dart';
import 'package:online_exam_app/core/helper/handel_cubit_states.dart';

@injectable
class ExamViewModel extends Cubit<ExamStates> {
  ExamViewModel(this._examQuestionsUseCase) : super(const ExamStates());
  final ExamQuestionsUseCase _examQuestionsUseCase;

  PageController pageController = PageController();
  List<Questions> questions = [];
  List<Answers> answers = [];
  Timer? _timer;


  void navigateToRoute(String routeName, BuildContext context) {
    routeName == state.navigationState;
    Navigator.pushReplacementNamed(context, routeName);
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

  void goToNextQuestion() {
    final nextIndex = (state.currentQuestionIndex ?? 0) + 1;
    if (nextIndex < questions.length) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      emit(state.copyWith(currentQuestionIndex: nextIndex));
    }
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

  void selectedAnswer(int answerIndex, int questionIndex) {
    final updatedSelectedAnswers =
        Map<int, int>.from(state.selectedAnswers ?? {});
    updatedSelectedAnswers[questionIndex] = answerIndex;

    emit(state.copyWith(
      selectedAnswers: updatedSelectedAnswers,
    ));
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
