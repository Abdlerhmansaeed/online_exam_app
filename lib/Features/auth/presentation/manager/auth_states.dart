import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/base_states/base_states.dart';

part 'auth_states.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    @Default(BaseStates.initial()) BaseStates loginStates,
    @Default(BaseStates.initial()) BaseStates signupStates,
    @Default(BaseStates.initial()) BaseStates forgetPasswordStates,
    @Default(BaseStates.initial()) BaseStates otpStates,
    @Default(BaseStates.initial()) BaseStates resetPasswordStates,
  }) = _AuthState;
}
