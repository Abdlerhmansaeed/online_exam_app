import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/Features/home/domain/entity/exams_on_subject_entity.dart';
import 'package:online_exam_app/Features/home/domain/use_case/get_exams_on_subject_use_case.dart';
import 'package:online_exam_app/Features/home/domain/use_case/home_tab_use_cse.dart';
import 'package:online_exam_app/Features/home/presentation/cubit/home_cubit.dart';
import 'package:online_exam_app/Features/home/presentation/pages/subject_details.dart';
import 'package:online_exam_app/Features/home/presentation/widgets/build_search_field.dart';
import 'package:online_exam_app/Features/home/presentation/widgets/subject_item.dart';
import 'package:online_exam_app/core/di/di.dart';
import 'package:online_exam_app/core/routes/app_routes.dart';
import 'package:online_exam_app/core/theme/app_colors.dart';
import '../../../../core/helper/spacing.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeCubit homeCubit = HomeCubit(
      getIt<GetAllSubjectsUseCase>(), getIt<GetExamsOnSubjectUseCase>());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.0.w,
        vertical: 16.0.h,
      ),
      child: BlocProvider(
        create: (context) => homeCubit..getAllSubjects(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Survey',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: AppColors.blue)),
            verticalSpace(16),
            const BuildSearchField(),
            verticalSpace(40),
            Text('Browse by subject',
                style: Theme.of(context).textTheme.titleLarge),
            verticalSpace(24),
            BlocBuilder<HomeCubit, HomeState>(
              // bloc: homeCubit..getAllSubjects(),
              builder: (context, state) {
                return state is HomeSuccessState
                    ? Expanded(
                        child: ListView.builder(
                            itemCount: state.subjectsEntity.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, AppRoutes.subjectDetails,arguments: state.subjectsEntity[index]);
                                },
                                child: SubjectAndExamItem(
                                  imageUrl:
                                      state.subjectsEntity[index].icon ?? '',
                                  name: state.subjectsEntity[index].name ?? '',
                                ),
                              );
                            }))
                    : const Center(child: CircularProgressIndicator());
              },
            )
          ],
        ),
      ),
    ));
  }
}
