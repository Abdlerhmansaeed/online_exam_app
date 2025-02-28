

import '../../../../core/base_states/base_states.dart';

class AuthState {
 final BaseStates? loginStates;
 final BaseStates? signupStates;
 final BaseStates? forgetPasswordStates;
 final BaseStates? otpStates;
 final BaseStates? resetPasswordStates;


  AuthState(
      {this.loginStates,
      this.signupStates,
      this.forgetPasswordStates,
      this.otpStates,
      this.resetPasswordStates});
  AuthState copyWith(
      {BaseStates? loginStates,
      BaseStates? signupStates,
      BaseStates? forgetPasswordStates,
      BaseStates? otpStates,
      BaseStates? resetPasswordStates}) {
    return AuthState(
        loginStates: loginStates?? this.loginStates,
        signupStates: signupStates?? this.signupStates,
        forgetPasswordStates: forgetPasswordStates?? this.forgetPasswordStates,
        otpStates: otpStates?? this.otpStates,
        resetPasswordStates: resetPasswordStates?? this.resetPasswordStates);
  }
}
