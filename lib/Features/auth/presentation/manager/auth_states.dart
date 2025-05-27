// import 'package:freezed_annotation/freezed_annotation.dart';
// import '../../../../core/base_states/base_states.dart';

// part 'auth_states.freezed.dart';

// @freezed
// class AuthState with _$AuthState {
//   const factory AuthState({
//     @Default(BaseStates.initial()) BaseStates loginStates,
//     @Default(BaseStates.initial()) BaseStates signupStates,
//     @Default(BaseStates.initial()) BaseStates forgetPasswordStates,
//     @Default(BaseStates.initial()) BaseStates otpStates,
//     @Default(BaseStates.initial()) BaseStates resetPasswordStates,
//   }) = _AuthState;
// }

import 'package:equatable/equatable.dart';
import 'package:online_exam_app/core/base_states/app_states.dart';

class AuthStates extends Equatable {
  final AppStates? loginStates;
  final AppStates? signupStates;
  final AppStates? forgetPasswordStates;
  final AppStates? otpStates;
  final AppStates? resetPasswordStates;

 const AuthStates({
    this.loginStates,
    this.signupStates,
    this.forgetPasswordStates,
    this.otpStates,
    this.resetPasswordStates,
  });

  AuthStates copyWith({
    AppStates? loginStates,
    AppStates? signupStates,
    AppStates? forgetPasswordStates,
    AppStates? otpStates,
    AppStates? resetPasswordStates,
  }) {
    return AuthStates(
      loginStates: loginStates ?? this.loginStates,
      signupStates: signupStates ?? this.signupStates,
      forgetPasswordStates: forgetPasswordStates ?? this.forgetPasswordStates,
      otpStates: otpStates ?? this.otpStates,
      resetPasswordStates: resetPasswordStates ?? this.resetPasswordStates,
    );
  }

  @override
  List<Object?> get props => [
    loginStates,
    signupStates,
    forgetPasswordStates,
    otpStates,
    resetPasswordStates,
  ];
}
