import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:online_exam_app/Features/auth/presentation/manager/auth_states.dart';
import 'package:online_exam_app/Features/home/presentation/pages/home_tab.dart';
import 'package:online_exam_app/Features/profile/presentation/pages/profile_page.dart';
import 'package:online_exam_app/Features/result/presentation/pages/result_page.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
    HomeCubit() : super(HomeInitial());
  int selectedIndex= 0;
  List<Widget> tabs = [
   const HomePage(),
    const ResultPage(),
    const ProfilePage()
  ];

  changeBottomNavBar(int newIndex){
    // emit(HomeInitial());
    selectedIndex = newIndex;
    emit(ChangeBottomNavBarState());
  }
}
