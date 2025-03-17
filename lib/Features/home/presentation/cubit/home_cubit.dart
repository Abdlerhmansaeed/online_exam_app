import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/exams/data/data_sources/local_data_source/exam_local_data_base.dart';
import 'package:online_exam_app/Features/home/data/model/get_exams_on_subject.dart';
import 'package:online_exam_app/Features/home/domain/entity/all_subjects_entity.dart';
import 'package:online_exam_app/Features/exams/domain/use_cases/get_exams_on_subject_use_case.dart';
import 'package:online_exam_app/Features/home/presentation/pages/home_screen.dart';
import 'package:online_exam_app/Features/user_profile/presentation/pages/profile_page.dart';
import 'package:online_exam_app/Features/user_results/presentation/pages/result_page.dart';
import 'package:online_exam_app/core/helper/handel_cubit_states.dart';
import '../../domain/use_case/home_tab_use_cse.dart';
part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
   final GetAllSubjectsUseCase _getAllExamsUseCase;

  static HomeCubit get(context) => BlocProvider.of(context);
  HomeCubit(
    this._getAllExamsUseCase,
  ) : super(HomeInitial());
  int selectedIndex = 0;
  List<Widget> tabs = [
    const HomeScreen(),
    const ResultPage(),
    const ProfilePage()
  ];

  changeBottomNavBar(int newIndex) {
    selectedIndex = newIndex;
    emit(ChangeBottomNavBarState());
  }

  Future<void> getAllSubjects() async {
    return handleCubitStates<List<SubjectsEntity>>(
      request: () => _getAllExamsUseCase.invoke(),
      onSuccess: (data) => emit(HomeSuccessState(subjectsList: data)),
      onError: (error) => emit(HomeErrorState(errorMessage: error)),
      onLoading: () => emit(HomeLoadingState()),
    );

  }

}
