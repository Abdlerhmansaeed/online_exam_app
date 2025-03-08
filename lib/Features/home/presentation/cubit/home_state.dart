part of 'home_cubit.dart';

@immutable
sealed class HomeState {}
final class HomeInitial extends HomeState {}
final class ChangeBottomNavBarState extends HomeState {}
final class HomeLoadingState extends HomeState {}
final class HomeErrorState extends HomeState {
  final String errorMessage;
  HomeErrorState({required this.errorMessage});
}
final class HomeSuccessState extends HomeState {
  List<SubjectsEntity> subjectsList;
  HomeSuccessState({required this.subjectsList});

}

final class ExamOnSubjectSuccessState extends HomeState {
List<Exams> examsList;
  ExamOnSubjectSuccessState({required this.examsList});
 

}