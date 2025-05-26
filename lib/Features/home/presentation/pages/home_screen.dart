import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/Features/home/presentation/cubit/home_cubit.dart';
import 'package:online_exam_app/Features/home/presentation/cubit/home_state.dart';
import 'package:online_exam_app/Features/home/presentation/widgets/build_search_field.dart';
import 'package:online_exam_app/Features/home/presentation/widgets/home_shimmer_loading.dart';
import 'package:online_exam_app/Features/home/presentation/widgets/home_sliver_shimmer.dart';
import 'package:online_exam_app/Features/home/presentation/widgets/subject_item.dart';
import 'package:online_exam_app/core/base_states/base_states.dart';
import 'package:online_exam_app/core/di/di.dart';
import 'package:online_exam_app/core/routes/app_routes.dart';
import 'package:online_exam_app/core/theme/app_colors.dart';
import '../../../../core/helper/spacing.dart';
import '../../domain/entity/all_subjects_entity.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeCubit homeCubit;
  bool _hasInitialized = false;

  @override
  void initState() {
    super.initState();
    homeCubit = getIt<HomeCubit>();

    // Only call once during initialization
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_hasInitialized) {
        _hasInitialized = true;
        homeCubit.getAllSubjects();
      }
    });
  }

  Future<void> _manualRefresh() async {
    await homeCubit.getAllSubjects(forceRefresh: true);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: _manualRefresh,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              pinned: true,
              floating: true,
              snap: true,
              toolbarHeight: 60.h,
              automaticallyImplyLeading: false,
              title: Text(
                'Survey',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: AppColors.blue),
              ),
            ),

            // 2. باقي الـ Slivers كما هي
            BlocBuilder<HomeCubit, HomeState<List<SubjectsEntity>>>(
              bloc: homeCubit,
              builder: (context, state) {
                return state.when(
                  initial: () => const HomeSliverShimmer(),
                  loading: () => const HomeSliverShimmer(),
                  success: (subjects) => subjects.isEmpty
                      ? SliverFillRemaining(child: _buildEmptyState(context))
                      : SliverList(
                          delegate: SliverChildListDelegate([
                            // Search Field
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                              child: const BuildSearchField(),
                            ),

                            // Section Header
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.0.w, vertical: 24.0.h),
                              child: Text(
                                'All Subjects',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),

                            // Subjects List
                            _buildSubjectsList(subjects, context),
                          ]),
                        ),
                  error: (message) => SliverFillRemaining(
                      child: _buildErrorState(context, message)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox_outlined, size: 64.r, color: Colors.grey[400]),
          verticalSpace(16),
          Text(
            'No Subjects Found',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Colors.grey[600]),
          ),
          verticalSpace(8),
          Text(
            'Come back later to check for new subjects.',
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
          verticalSpace(24),
          ElevatedButton.icon(
            onPressed: () => homeCubit.getAllSubjects(forceRefresh: true),
            icon: const Icon(Icons.refresh, color: Colors.white),
            label: const Text(
              'Refresh Subjects',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.blue,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectsList(
      List<SubjectsEntity> subjects, BuildContext context) {
    return Column(
      children: subjects.asMap().entries.map((entry) {
        final index = entry.key;
        final subject = entry.value;
        return AnimatedContainer(
          duration: Duration(milliseconds: 300 + (index * 50)),
          curve: Curves.easeInOut,
          margin: EdgeInsets.only(bottom: 12.h),
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.subjectDetails,
                arguments: subject,
              );
            },
            borderRadius: BorderRadius.circular(12.r),
            child: SubjectItem(
              imageUrl: subject.icon,
              name: subject.name,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 40.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20.r),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.error_outline_rounded,
                  size: 48.r, color: Colors.red),
            ),
            verticalSpace(24),
            Text(
              'Error Occurred',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            verticalSpace(8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                    height: 1.5,
                  ),
            ),
            verticalSpace(32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () => homeCubit.getAllSubjects(forceRefresh: true),
                  icon: const Icon(Icons.refresh, color: Colors.white),
                  label: const Text('Retry',
                      style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blue,
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),
                horizontalSpace(16),
                OutlinedButton.icon(
                  onPressed: () => Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.loginPage,
                    (route) => false,
                  ),
                  icon: const Icon(Icons.logout, color: Colors.red),
                  label:
                      const Text('Logout', style: TextStyle(color: Colors.red)),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.red),
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
