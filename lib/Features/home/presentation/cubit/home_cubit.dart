// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/home/data/model/get_exams_on_subject.dart';
import 'package:online_exam_app/Features/home/domain/entity/all_subjects_entity.dart';
import 'package:online_exam_app/Features/home/domain/use_case/get_exams_on_subject_use_case.dart';
import 'package:online_exam_app/Features/home/presentation/pages/home_screen.dart';
import 'package:online_exam_app/Features/user_profile/presentation/pages/profile_page.dart';
import 'package:online_exam_app/Features/user_results/presentation/pages/result_page.dart';
import 'package:online_exam_app/core/helper/handel_cubit_states.dart';
import '../../domain/use_case/home_tab_use_cse.dart';
part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  GetAllSubjectsUseCase _getAllExamsUseCase;
  GetExamsOnSubjectUseCase _getExamsOnSubjectUseCase;

  static HomeCubit get(context) => BlocProvider.of(context);
  HomeCubit(
    this._getAllExamsUseCase,
    this._getExamsOnSubjectUseCase,
  ) : super(HomeInitial());
  int selectedIndex = 0;
  List<Widget> tabs = [
    const HomeScreen(),
    const ResultPage(),
    const ProfilePage()
  ];

  changeBottomNavBar(int newIndex) {
    // emit(HomeInitial());
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

    // emit(HomeLoadingState());
    // var either = await getAllExamsUseCase.invoke();
    // either.fold(
    //   (error) {
    //     emit(HomeErrorState(errorMessage: error.errorMessage));
    //   },
    //   (success) {
    //     emit(HomeSuccessState(subjectsList:success?? []));
    //   },
    // );
  }

 Future<void> getExamsOnSubject(String subjectId) async {
    return handleCubitStates<GetExamsOnSubject>(
      request: () => _getExamsOnSubjectUseCase.invoke(subjectId),
      onSuccess: (data) => emit(ExamOnSubjectSuccessState(examsList: data.exams ?? [])),
      onError: (error) => emit(HomeErrorState(errorMessage: error)),
      onLoading: () => emit(HomeLoadingState()),
    );
    // emit(HomeLoadingState());
    // var either = await _getExamsOnSubjectUseCase.invoke(subjectId);
    // either.fold(
    //   (error) {
    //     emit(HomeErrorState(errorMessage: error.errorMessage));
    //   },
    //   (success) {
    //     emit(ExamOnSubjectSuccessState(examsList: success.exams ?? []));
    //   },
    // );
  }
}
