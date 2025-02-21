import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/home_cubit.dart';
import '../widgets/build_bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
HomeCubit homeCubit = HomeCubit();
class _HomeScreenState extends State<HomeScreen> {
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
