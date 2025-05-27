import 'package:equatable/equatable.dart';
import 'package:online_exam_app/core/base_states/app_states.dart';


class ProfileStates extends Equatable{
  final AppStates? getUserProfileStates;
  final AppStates? changePassword;
  final AppStates? editProfile;
  const ProfileStates(
      {this.getUserProfileStates,
        this.changePassword,
        this.editProfile});
  ProfileStates copyWith(
      {AppStates? getUserProfileStates,
        AppStates? changePassword,
        AppStates? editProfile}) {
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