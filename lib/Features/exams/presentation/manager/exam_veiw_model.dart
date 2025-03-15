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
  ExamViewModel(
      this._examQuestionsUseCase,
      this.examLocalDataSource,
      this._checkUserAnswersUseCase,
      ) : super(const ExamStates());

  final ExamQuestionsUseCase _examQuestionsUseCase;
  final CheckUserAnswersUseCase _checkUserAnswersUseCase;
  final ExamLocalDataSource? examLocalDataSource;

  PageController pageController = PageController();
  List<Questions> questions = [];
  List<ExamAnswers> answers = [];
  Timer? _timer;
  List<UserAnswers> selectedAnswers = [];
  bool isLastQuestion = false;

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

    Navigator.pushReplacementNamed(
      context,
      routeName,
      arguments: arguments,
    );
    emit(state.copyWith(navigationState: routeName));
  }

  Future<void> getExamQuestions(String? examId) async {
    await handleCubitStates<ExamQuestionsResponse>(
      request: () => _examQuestionsUseCase.call(examId),
      onLoading: () => emit(state.copyWith(examStates: LoadingState())),
      onSuccess: (data) {
        questions = data.questions ?? [];
        answers.clear();
        for (var q in questions) {
          answers.addAll(q.answers?.where((examAnswers) => examAnswers.answer != null).map((examAnswers) => ExamAnswers(key: q.Id, answer: examAnswers.answer)) ?? []);
        }

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
    } else {
       emit(state.copyWith(isLastQuestion: true));
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

  void selectedUserAnswer(
      int answerIndex,
      int questionIndex,
      String questionId,
      String correctAnswerId,
      ) async {
    print("examLocalDataSource: $examLocalDataSource");
    final newSelectedAnswers = {...?state.selectedAnswers};
    newSelectedAnswers[questionIndex] = answerIndex;

    final newUserAnswers = List<UserAnswers>.from(state.userAnswers ?? []);
    final existingIndex = newUserAnswers.indexWhere((answers) => answers.questionId == questionId);

    if (existingIndex != -1) {
      newUserAnswers[existingIndex] = UserAnswers(
        questionId: questionId,
        correct: correctAnswerId,
      );
    } else {
      newUserAnswers.add(UserAnswers(
        questionId: questionId,
        correct: correctAnswerId,
      ));
    }

    try {
      if (examLocalDataSource == null) throw Exception("DataSource not initialized");

      await examLocalDataSource!.saveAnswers(newUserAnswers);
      final savedAnswers = await examLocalDataSource!.getAnswers();
      print("Saved Answers: ${savedAnswers.map((e) => "${e.questionId}: ${e.correct}").toList()}");

      emit(state.copyWith(
        selectedAnswers: newSelectedAnswers,
        userAnswers: newUserAnswers.cast<UserAnswers>(),
      ));
    } catch (e) {
      print("Error saving answers: ${e.toString()}");
    }
  }

  Future<void> checkUserAnswers() async {
    return handleCubitStates<CheckQuestionsResponse>(
      request: () async {
        final userAnswers = await examLocalDataSource?.getAnswers() ?? [];
        if (userAnswers.isEmpty) throw Exception("No answers found");

        final userAnswerList = userAnswers.map<UserAnswers>((answer) => UserAnswers(
          questionId: answer.questionId,
          correct: answer.correct,
        )).toList();

        return await _checkUserAnswersUseCase.call(
          CheckQuestionsRequest(answers: userAnswerList),
        );
      },
      onSuccess: (data) {
        emit(state.copyWith(
          checkUserAnswersStates: SuccessState<CheckQuestionsResponse>(data),
        ));
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
    int examDurationInSeconds = (durationInMinutes * 60).round();
    const oneSec = Duration(seconds: 1);

    _timer = Timer.periodic(
      oneSec,
          (timer) {
        if (examDurationInSeconds == 0) {
          timer.cancel();
          emit(state.copyWith(examDuration: 0, examTimeOutState: true));
        } else {
          examDurationInSeconds--;
          emit(state.copyWith(examDuration: examDurationInSeconds));
        }
      },
    );
  }

  void cancelTimer() {
    _timer?.cancel();
  }
}