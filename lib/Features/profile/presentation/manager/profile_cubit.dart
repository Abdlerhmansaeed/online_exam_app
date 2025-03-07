import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/profile/data/models/Change_password_response.dart';
import 'package:online_exam_app/Features/profile/data/models/change_password_request.dart';
import 'package:online_exam_app/Features/profile/data/models/edit_profile_request.dart';
import 'package:online_exam_app/Features/profile/data/models/edit_profile_response.dart';
import 'package:online_exam_app/Features/profile/data/models/get_user_profile_response.dart';
import 'package:online_exam_app/Features/profile/domain/use_cases/change_password_use_case.dart';
import 'package:online_exam_app/Features/profile/domain/use_cases/edit_profile_use_case.dart';
import 'package:online_exam_app/Features/profile/domain/use_cases/get_user_profile_use_case.dart';
import 'package:online_exam_app/Features/profile/presentation/manager/profile_states.dart';
import 'package:online_exam_app/core/base_states/base_states.dart';


@injectable
class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit(this._editProfileUseCase,this._getUserProfileUseCase,this._changePasswordUseCase) : super(ProfileStates());

  final ChangePasswordUseCase _changePasswordUseCase;
  final GetUserProfileUseCase _getUserProfileUseCase;
  final EditProfileUseCase _editProfileUseCase;

  // Form Keys
  final profileFormKey = GlobalKey<FormState>();
  // Controllers
   TextEditingController emailController = TextEditingController();
   TextEditingController passwordController = TextEditingController();
   TextEditingController userNameController = TextEditingController();
   TextEditingController firstNameController = TextEditingController();
   TextEditingController lastNameController = TextEditingController();
   TextEditingController phoneNumberController = TextEditingController();
   TextEditingController newPasswordController = TextEditingController();
   TextEditingController confirmPasswordController = TextEditingController();

  Future<void> getUserProfile() async {
    emit(state.copyWith(getUserProfileStates:LoadingState()));
    try {
      var result = await _getUserProfileUseCase.call(

      );
      result.fold(
            (failure) => emit(state.copyWith(getUserProfileStates: ErrorState(failure))),
            (success) => emit(state.copyWith(getUserProfileStates: SuccessState<UserProfile>(success))),
      );
    } catch (e) {
      emit(state.copyWith(getUserProfileStates: ErrorState(e.toString())));
    }
  }

  Future<void> changePassword() async {
    emit(state.copyWith(changePassword:LoadingState()));
    try {
      var result = await _changePasswordUseCase.call(
        ChangePasswordRequest(passwordController.text, newPasswordController.text,  confirmPasswordController.text)

      );
      result.fold(
            (failure) => emit(state.copyWith(changePassword: ErrorState(failure))),
            (success) => emit(state.copyWith(changePassword: SuccessState<ChangePasswordResponse>(success))),

      );
    } catch (e) {
      emit(state.copyWith(changePassword: ErrorState(e.toString())));
    }
  }
  Future<void> editProfile(EditProfileRequest editProfile) async {
    emit(state.copyWith(editProfile:LoadingState()));
    try {
      var result = await _editProfileUseCase.call(
          editProfile
      );
      result.fold(
            (failure) => emit(state.copyWith(editProfile: ErrorState(failure))),
            (success) => emit(state.copyWith(editProfile: SuccessState<EditUser>(success))),
      );
    } catch (e) {
      emit(state.copyWith(editProfile: ErrorState(e.toString())));
    }
  }


}