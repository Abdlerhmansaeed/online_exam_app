import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/core/helper/handel_cubit_states.dart';
import '../../../home/data/model/get_exams_on_subject.dart';

// Import the repository abstraction instead of data source
import '../../../exams/domain/repositories/exam_local_repository.dart';

// Import model classes
import '../../../exams/data/models/exam_result.dart';
import '../../../exams/data/models/user_answer.dart';
import '../../../exams/data/models/exam_details_model.dart';
import '../../../exams/data/models/exam_answers_model.dart';

part 'user_view_model_state.dart';

@injectable
class UserViewModelCubit extends Cubit<UserViewModelState> {
  UserViewModelCubit(this._examLocalRepository) : super(UserViewModelInitial());

  final ExamLocalRepository _examLocalRepository; // Use repository abstraction

  Future<void> getAllExamResults() async {
    handleCubitStates<List<ExamResult>>(
      request: () =>
          _examLocalRepository.getAllExamResults(), // Repository returns Either
      onSuccess: (data) {
        if (data.isEmpty) {
          emit(ExamResultsEmpty());
        } else {
          emit(ExamResultsSuccess(examResults: data));
        }
      },
      onError: (error) {
        emit(ExamResultsError(errorMessage: error));
      },
      onLoading: () {
        emit(ExamResultsLoading());
      },
    );
  }

  Future<void> getExamDetails(String examId) async {
    handleCubitStates<ExamDetailsModel>(
      request: () async {
        // Use repository methods that return Either
        final questionsMapResult =
            await _examLocalRepository.getQuestionsAsMap();
        final userAnswersMapResult =
            await _examLocalRepository.getUserAnswersMap();
        final userAnswersResult = await _examLocalRepository.getUserAnswers();
        final examResultResult =
            await _examLocalRepository.getLatestExamResult();

        // Handle Either results using fold
        return questionsMapResult.fold(
          (error) => Left(error),
          (questionsMap) => userAnswersMapResult.fold(
            (error) => Left(error),
            (userAnswersMap) => userAnswersResult.fold(
              (error) => Left(error),
              (userAnswers) => examResultResult.fold(
                (error) => Left(error),
                (examResult) => Right(ExamDetailsModel(
                  questionsMap: questionsMap,
                  userAnswersMap: userAnswersMap,
                  userAnswers: userAnswers,
                  examResult: examResult,
                  examId: examId,
                )),
              ),
            ),
          ),
        );
      },
      onSuccess: (data) {
        emit(ExamDetailsSuccess(
          questionsMap: data.questionsMap,
          userAnswersMap: data.userAnswersMap,
          userAnswers: data.userAnswers,
          examResult: data.examResult,
          examId: data.examId,
        ));
      },
      onError: (error) {
        emit(ExamDetailsError(errorMessage: error));
      },
      onLoading: () {
        emit(ExamDetailsLoading());
      },
    );
  }

  Future<void> getExamAnswers(Exams exam) async {
    handleCubitStates<ExamAnswersModel>(
      request: () async {
        // Use repository methods that return Either
        final questionsMapResult =
            await _examLocalRepository.getQuestionsAsMap();
        final userAnswersMapResult =
            await _examLocalRepository.getUserAnswersMap();
        final userAnswersResult = await _examLocalRepository.getUserAnswers();

        // Handle Either results using fold
        return questionsMapResult.fold(
          (error) => Left(error),
          (questionsMap) => userAnswersMapResult.fold(
            (error) => Left(error),
            (userAnswersMap) => userAnswersResult.fold(
              (error) => Left(error),
              (userAnswers) => Right(ExamAnswersModel(
                exam: exam,
                questionsMap: questionsMap,
                userAnswersMap: userAnswersMap,
                userAnswers: userAnswers,
              )),
            ),
          ),
        );
      },
      onSuccess: (data) {
        emit(ExamAnswersSuccess(
          exam: data.exam,
          questionsMap: data.questionsMap,
          userAnswersMap: data.userAnswersMap,
          userAnswers: data.userAnswers,
        ));
      },
      onError: (error) {
        emit(ExamAnswersError(errorMessage: error));
      },
      onLoading: () {
        emit(ExamAnswersLoading());
      },
    );
  }
}
