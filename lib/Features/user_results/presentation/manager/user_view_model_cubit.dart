import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../home/data/model/get_exams_on_subject.dart';
import '../../../exams/domain/repositories/exam_local_repository.dart';
import '../../../exams/data/models/exam_result.dart';
import '../../../exams/data/models/user_answer.dart';


part 'user_view_model_state.dart';

@injectable
class UserViewModelCubit extends Cubit<UserViewModelState> {
  UserViewModelCubit(this._examLocalRepository) : super(UserViewModelInitial());

  final ExamLocalRepository _examLocalRepository;

  Future<void> getAllExamResults() async {
    emit(ExamResultsLoading());

    try {
      final result = await _examLocalRepository.getAllExamResults();

      result.fold(
       (l) => emit(ExamResultsError(errorMessage: l)),
       (r) => emit(
          ExamResultsSuccess(examResults: r),
        ),
      );
    } catch (e) {
      emit(ExamResultsError(errorMessage: e.toString()));
    }
  }

  Future<void> getExamDetails(String examId) async {
    emit(ExamDetailsLoading());

    try {
      final questionsMapResult = await _examLocalRepository.getQuestionsAsMap();
      final userAnswersMapResult =
          await _examLocalRepository.getUserAnswersMap();
      final userAnswersResult = await _examLocalRepository.getUserAnswers();
      final examResultResult = await _examLocalRepository.getLatestExamResult();

      bool allSuccessful = true;
      String errorMessage = '';

      questionsMapResult.fold((error) {
        allSuccessful = false;
        errorMessage = error;
      }, (questionsMap) {
        userAnswersMapResult.fold((error) {
          allSuccessful = false;
          errorMessage = error;
        }, (userAnswersMap) {
          userAnswersResult.fold((error) {
            allSuccessful = false;
            errorMessage = error;
          }, (userAnswers) {
            examResultResult.fold((error) {
              allSuccessful = false;
              errorMessage = error;
            }, (examResult) {
              emit(ExamDetailsSuccess(
                questionsMap: questionsMap,
                userAnswersMap: userAnswersMap,
                userAnswers: userAnswers,
                examResult: examResult,
                examId: examId,
              ));
            });
          });
        });
      });

      if (!allSuccessful) {
        emit(ExamDetailsError(errorMessage: errorMessage));
      }
    } catch (e) {
      emit(ExamDetailsError(errorMessage: e.toString()));
    }
  }

  Future<void> getExamAnswers(Exams exam) async {
    emit(ExamAnswersLoading());

    try {
      final questionsMapResult = await _examLocalRepository.getQuestionsAsMap();
      final userAnswersMapResult =
          await _examLocalRepository.getUserAnswersMap();
      final userAnswersResult = await _examLocalRepository.getUserAnswers();

      bool allSuccessful = true;
      String errorMessage = '';

      questionsMapResult.fold((error) {
        allSuccessful = false;
        errorMessage = error;
      }, (questionsMap) {
        userAnswersMapResult.fold((error) {
          allSuccessful = false;
          errorMessage = error;
        }, (userAnswersMap) {
          userAnswersResult.fold((error) {
            allSuccessful = false;
            errorMessage = error;
          }, (userAnswers) {
            emit(ExamAnswersSuccess(
              exam: exam,
              questionsMap: questionsMap,
              userAnswersMap: userAnswersMap,
              userAnswers: userAnswers,
            ));
          });
        });
      });

      if (!allSuccessful) {
        emit(ExamAnswersError(errorMessage: errorMessage));
      }
    } catch (e) {
      emit(ExamAnswersError(errorMessage: e.toString()));
    }
  }
}
