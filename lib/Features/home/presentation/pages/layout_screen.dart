import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app/Features/home/domain/use_case/home_tab_use_cse.dart';
import 'package:online_exam_app/Features/home/presentation/cubit/home_cubit.dart';
import 'package:online_exam_app/core/di/di.dart';
import '../widgets/build_bottom_nav_bar.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(getIt<GetAllSubjectsUseCase>(),)..getAllSubjects(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final homeCubit =context.read<HomeCubit>();
          return Scaffold(
            body: homeCubit.tabs[homeCubit.selectedIndex],
            bottomNavigationBar: BuildBottomNavBar(
              context: context,
              selectedIndex: homeCubit.selectedIndex,
              onTabFunction: (newIndex) {
                homeCubit.changeBottomNavBar(newIndex);
              },
            ),
          );
        },
      ),
    );
  }
}