import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/Features/user_profile/data/models/change_password_request.dart';
import 'package:online_exam_app/Features/user_profile/domain/use_cases/get_user_profile_use_case.dart';
import 'package:online_exam_app/Features/user_profile/presentation/manager/profile_view_model_state.dart';
import '../../../../core/base_states/base_states.dart';
import '../../../../core/helper/handel_cubit_states.dart';
import '../../data/models/edit_profile_request.dart';
import '../../domain/use_cases/change_user_password_use_case.dart';
import '../../domain/use_cases/edit_profile_use_case.dart';

@injectable
class ProfileViewModelCubit extends Cubit<ProfileStates> {
  ProfileViewModelCubit(this._getUserProfileUseCase,
      this._changeUserPasswordUseCase, this._editProfileUseCase)
      : super(const ProfileStates());

  // Form Keys
  final profileFormKey = GlobalKey<FormState>();

  final GetUserProfileUseCase _getUserProfileUseCase;
  final ChangeUserPasswordUseCase _changeUserPasswordUseCase;
  final EditProfileUseCase _editProfileUseCase;
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
    return handleCubitStates(
        request: () => _getUserProfileUseCase.call(),
        onSuccess: (data) {
          emailController.text = data.email ?? '';
          userNameController.text = data.userName ?? '';
          firstNameController.text = data.firstName ?? '';
          lastNameController.text = data.lastName ?? '';
          phoneNumberController.text = data.phone ?? '';
          emit(state.copyWith(getUserProfileStates: SuccessState(data)));
        },
        onError: (error) =>
            emit(state.copyWith(getUserProfileStates: ErrorState(error))),
        onLoading: () =>
            emit(state.copyWith(getUserProfileStates: const LoadingState())));
  }

  Future<void> changePassword() async {
    return handleCubitStates(
        request: () => _changeUserPasswordUseCase.call(
            data: ChangePasswordRequest(
                oldPassword: passwordController.text,
                password: newPasswordController.text,
                rePassword: confirmPasswordController.text)),
        onSuccess: (data) {
          emit(state.copyWith(changePassword: SuccessState(data)));
        },
        onError: (error) =>
            emit(state.copyWith(changePassword: ErrorState(error))),
        onLoading: () =>
            emit(state.copyWith(changePassword: const LoadingState())));
  }

  Future<void> editProfile() async {
    return handleCubitStates(
        request: () => _editProfileUseCase.call(
              data: EditProfileRequest(
                firstName: firstNameController.text,
                lastName: lastNameController.text,
                phone: phoneNumberController.text,
                email: emailController.text,
              ),
            ),
        onSuccess: (data) {
          emit(state.copyWith(editProfile: SuccessState(data)));
        },
        onError: (error) =>
            emit(state.copyWith(editProfile: ErrorState(error))),
        onLoading: () =>
            emit(state.copyWith(editProfile: const LoadingState())));
  }
}
