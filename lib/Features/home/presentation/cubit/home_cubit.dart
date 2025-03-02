// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/home/domain/entity/all_subjects_entity.dart';
import 'package:online_exam_app/Features/home/domain/entity/exams_on_subject_entity.dart';
import 'package:online_exam_app/Features/home/domain/use_case/get_exams_on_subject_use_case.dart';
import 'package:online_exam_app/Features/home/presentation/pages/home_screen.dart';
import 'package:online_exam_app/Features/profile/presentation/pages/profile_page.dart';
import 'package:online_exam_app/Features/user_results/presentation/pages/result_page.dart';
import '../../domain/use_case/home_tab_use_cse.dart';
part 'home_state.dart';
@injectable
class HomeCubit extends Cubit<HomeState> {
  GetAllSubjectsUseCase getAllExamsUseCase;
  GetExamsOnSubjectUseCase getExamsOnSubjectUseCase;

  static HomeCubit get(context) => BlocProvider.of(context);
  HomeCubit(
    this.getAllExamsUseCase,
    this.getExamsOnSubjectUseCase,
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

  getAllSubjects() async {
    emit(HomeLoadingState());
    var either = await getAllExamsUseCase.invoke();
    either.fold(
      (l) {
        emit(HomeErrorState(errorMessage: l.errorMessage));
      },
      (r) {
        emit(HomeSuccessState(subjectsEntity: r));
      },
    );
  }

  getExamsOnSubject(String subjectId) async {
    emit(HomeLoadingState());
    var either = await getExamsOnSubjectUseCase.invoke(subjectId);
    either.fold((l) => emit(HomeErrorState(errorMessage: l.errorMessage)),
        (r) => emit(ExamOnSubjectSuccessState(examsOnSubjectEntity: r)));
  }
}
