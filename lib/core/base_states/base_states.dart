sealed class BaseStates {}

class InitialState extends BaseStates {}

class LoadingState extends BaseStates {}

class ErrorState extends BaseStates {
  String? error;

  ErrorState(this.error);
}

class SuccessState<T> extends BaseStates {
  T? data;
  SuccessState(this.data);
}
