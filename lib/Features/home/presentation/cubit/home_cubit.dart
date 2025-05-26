// ignore_for_file: unnecessary_type_check

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/home/domain/entity/all_subjects_entity.dart';
import 'package:online_exam_app/Features/home/presentation/cubit/home_state.dart';
import 'package:online_exam_app/core/base_states/base_states.dart';
import '../../domain/use_case/home_tab_use_cse.dart';

@injectable
class HomeCubit extends Cubit<HomeState<List<SubjectsEntity>>> {
  final GetAllSubjectsUseCase _getAllSubjectsUseCase;

  HomeCubit(this._getAllSubjectsUseCase) : super(const HomeState.initial());

  static HomeCubit get(context) => BlocProvider.of(context);

  ValueNotifier<int> currentIndex = ValueNotifier(0);

  Future<void> getAllSubjects({bool forceRefresh = false}) async {
    debugPrint('🔄 HomeCubit: getAllSubjects called');
    debugPrint('   📋 forceRefresh: $forceRefresh');
    debugPrint('   📋 current state: ${state.runtimeType}');

    // Show loading in these cases:
    // 1. First time loading (not forceRefresh)
    // 2. Force refresh from user action
    // 3. Current state is not success (error or initial)
    final shouldShowLoading = !forceRefresh ||
        state is! SuccessState<List<SubjectsEntity>> ||
        forceRefresh;

    if (shouldShowLoading) {
      emit(const HomeState.loading());
    }

    try {
      final result =
          await _getAllSubjectsUseCase.invoke(forceRefresh: forceRefresh);

      result.fold(
        (failure) {
          emit(HomeState.error(failure.toString()));
        },
        (data) {
          emit(HomeState.success(data));
        },
      );
    } catch (e) {
      debugPrint('💥 HomeCubit: Exception - $e');
      emit(HomeState.error(e.toString()));
    }
  }

  Future<void> refreshInBackground() async {
    if (state is SuccessState<List<SubjectsEntity>>) {
      await getAllSubjects(forceRefresh: true);
    }
  }
}
