import 'package:equatable/equatable.dart';

import '../../../../core/base_states/base_states.dart';

class ProfileStates extends Equatable{
  final BaseStates? getUserProfileStates;
  final BaseStates? changePassword;
  final BaseStates? editProfile;
  const ProfileStates(
      {this.getUserProfileStates,
        this.changePassword,
        this.editProfile});
  ProfileStates copyWith(
      {BaseStates? getUserProfileStates,
        BaseStates? changePassword,
        BaseStates? editProfile}) {
    return ProfileStates(
        getUserProfileStates: getUserProfileStates?? this.getUserProfileStates,
        changePassword: changePassword?? this.changePassword,
        editProfile: editProfile?? this.editProfile);
  }
  
  @override
  List<Object?> get props => [
    getUserProfileStates,
    changePassword,
    editProfile
  ];
}