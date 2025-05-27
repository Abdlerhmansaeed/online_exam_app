import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app/Features/home/presentation/cubit/home_cubit.dart';
import 'package:online_exam_app/Features/home/presentation/pages/home_screen.dart';
import 'package:online_exam_app/Features/user_profile/presentation/manager/profile_view_model_cubit.dart';
import 'package:online_exam_app/Features/user_profile/presentation/pages/profile_page.dart';
import 'package:online_exam_app/Features/user_results/presentation/pages/result_page.dart';
import 'package:online_exam_app/core/app_manger/app_manger.dart';
import 'package:online_exam_app/core/di/di.dart';
import '../widgets/build_bottom_nav_bar.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  static const _screenLifetime = Duration(minutes: 5);

  final Map<int, Widget> _createdTabs = {};

  final Map<int, DateTime> _lastVisitTime = {};

  Timer? _cleanupTimer;

  @override
  void initState() {
    super.initState();
    _cleanupTimer =
        Timer.periodic(const Duration(minutes: 1), _cleanupOldScreens);
  }

  @override
  void dispose() {
    _cleanupTimer?.cancel();
    super.dispose();
  }

  void _cleanupOldScreens(Timer timer) {
    final now = DateTime.now();
    final expiredTabs = _lastVisitTime.entries
        .where((entry) => now.difference(entry.value) > _screenLifetime)
        .map((entry) => entry.key)
        .toList();

    if (expiredTabs.isNotEmpty) {
      setState(() {
        for (final tabIndex in expiredTabs) {
          if (tabIndex != context.read<AppManger>().state.bottomNavBarIndex) {
            debugPrint(
                '🧹clearing Tab($tabIndex) using From memory$_screenLifetime');
            _createdTabs.remove(tabIndex);
            _lastVisitTime.remove(tabIndex);
          }
        }
      });
    }
  }

  Widget _getOrCreateTab(int index) {
    _lastVisitTime[index] = DateTime.now();

    if (_createdTabs.containsKey(index)) {
      debugPrint('✅ Using From memory($index)');
      return _createdTabs[index]!;
    }

    debugPrint('✅ Using From memory($index)');
    ('🆕 creating New Tab($index)');
    late final Widget newTab;

    switch (index) {
      case 0:
        newTab = BlocProvider<HomeCubit>(
            create: (context) => getIt<HomeCubit>()..getAllSubjects(),
            child: const HomeScreen());
        break;
      case 1:
        newTab = const ResultPage();
        break;
      case 2:
        newTab = BlocProvider(
            create: (context) =>
                getIt<ProfileViewModelCubit>()..getUserProfile(),
            child: const ProfilePage());
        break;
      default:
        newTab = const SizedBox.shrink();
    }

    _createdTabs[index] = newTab;
    return newTab;
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = context.watch<AppManger>().state.bottomNavBarIndex;

    final screenWidgets = <int>[0, 1, 2].map((index) {
      final shouldCreate =
          index == currentIndex || _createdTabs.containsKey(index);

      return Offstage(
        offstage: index != currentIndex,
        child: shouldCreate ? _getOrCreateTab(index) : const SizedBox.shrink(),
      );
    }).toList();

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Stack(
          children: screenWidgets,
        ),
        bottomNavigationBar: BuildBottomNavBar(
          context: context,
          selectedIndex: currentIndex,
          onTabFunction: (newIndex) {
            context.read<AppManger>().changeBottomNavBar(newIndex);
          },
        ),
      ),
    );
  }
}
