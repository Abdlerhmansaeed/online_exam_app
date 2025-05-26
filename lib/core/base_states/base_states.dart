
import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_states.freezed.dart';

@freezed
sealed class BaseStates<T> with _$BaseStates<T> {
  const factory BaseStates.initial() = InitialState<T>;
  const factory BaseStates.loading() = LoadingState<T>;
  const factory BaseStates.success([T? data]) = SuccessState<T>;
  const factory BaseStates.error(String? error) = ErrorState<T>;
}
