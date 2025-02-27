import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app/Features/home/domain/use_case/home_tab_use_cse.dart';
import 'package:online_exam_app/core/di/di.dart';

import '../cubit/home_cubit.dart';
import '../widgets/build_bottom_nav_bar.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});
  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}
HomeCubit homeCubit =HomeCubit(getIt<GetAllSubjectsUseCase>());
class _LayoutScreenState extends State<LayoutScreen> {
  @override
  Widget build(BuildContext context) {
    return   BlocBuilder<HomeCubit, HomeState>(
     
      bloc: homeCubit,
      builder: (context, state) {
        return Scaffold(
            body: homeCubit.tabs[homeCubit.selectedIndex],
            bottomNavigationBar: BuildBottomNavBar(
              context: context,
              selectedIndex: homeCubit.selectedIndex,
              onTabFunction: (newIndex) {
                homeCubit.selectedIndex= newIndex;
                setState(() {

                });
              },
            )
        );
      },
    );
  }
}