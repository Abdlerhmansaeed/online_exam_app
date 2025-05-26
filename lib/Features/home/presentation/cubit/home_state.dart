import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState<T> with _$HomeState<T> {
  const factory HomeState.initial() = _Initial<T>;
  const factory HomeState.loading() = HomeLoading<T>;
  const factory HomeState.success(T data) = HomeSuccess<T>;
  const factory HomeState.error(String message) = HomeError<T>;
}