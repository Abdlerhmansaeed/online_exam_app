import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/core/app_manger/app_local_storage/app_local_storage.dart';
import 'package:online_exam_app/core/app_manger/app_state.dart';

@singleton
class AppManger extends Cubit<AppState> {
  AppManger(
    this._localStorage,
  ) : super(AppState.initial());

  final AppLocalStorage _localStorage;
  Future<void> getUserLoggedInState() async {
    final token = await _localStorage.getToken();
    final rememberMe = await _localStorage.getRememberMe();
    if (token != null && rememberMe == true) {
      emit(state.copyWith(isLoggedIn: true));
    }
  }

  void changeBottomNavBar(int newIndex) {
    emit(state.copyWith(bottomNavBarIndex: newIndex));
  }
}
