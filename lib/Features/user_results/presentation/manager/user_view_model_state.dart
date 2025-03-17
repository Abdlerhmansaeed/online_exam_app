part of 'user_view_model_cubit.dart';

sealed class UserViewModelState extends Equatable {
  const UserViewModelState();
}

final class UserViewModelInitial extends UserViewModelState {
  @override
  List<Object> get props => [];
}
class UserViewModelLoading extends UserViewModelState {
  @override
  List<Object> get props => [];
}
class UserViewModelSuccess extends UserViewModelState {
  final List<Exams> examsList;
  const UserViewModelSuccess({required this.examsList});
  @override
  List<Object> get props => [examsList];
}
class UserViewModelError extends UserViewModelState {
  final String errorMessage;
  const UserViewModelError({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}