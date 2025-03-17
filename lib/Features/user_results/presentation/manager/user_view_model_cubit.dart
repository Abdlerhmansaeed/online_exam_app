import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/core/helper/handel_cubit_states.dart';

import '../../../home/data/model/get_exams_on_subject.dart';
import '../../data/data_sources/user_results_data_source.dart';

part 'user_view_model_state.dart';
@injectable
class UserViewModelCubit extends Cubit<UserViewModelState> {
  UserViewModelCubit(this._userResultsDataSource)
      : super(UserViewModelInitial());
  final UserResultsDataSource _userResultsDataSource;

  Future<void> getUserResults() async {
    handleCubitStates(
      request: () async {
        try {
          final exams = await _userResultsDataSource.getSavedExams();
          return Right(exams);
        } catch (e) {
          return Left(e.toString());
        }
      },
      onSuccess: (data) {
        emit(UserViewModelSuccess(
            examsList: (data as List).map((e) => e as Exams).toList()));
      },
      onError: (error) {
        emit(UserViewModelError(errorMessage: error));
      },
      onLoading: () {
        emit(UserViewModelLoading());
      },
    );
  }
}
