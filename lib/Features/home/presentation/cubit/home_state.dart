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
List< SubjectsEntity> subjectsEntity;
  HomeSuccessState({required this.subjectsEntity});

}