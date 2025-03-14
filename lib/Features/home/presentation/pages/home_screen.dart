import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/Features/home/presentation/cubit/home_cubit.dart';
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

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {
  late final HomeCubit homeCubit;

  @override
  void initState() {
    super.initState();
    homeCubit = getIt<HomeCubit>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeCubit.getAllSubjects();
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.0.w,
          vertical: 16.0.h,
        ),
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
            Expanded(
              child: BlocBuilder<HomeCubit, HomeState>(
                bloc: homeCubit,
                builder: (context, state) {
                  switch (state) {
                    case HomeLoadingState _:
                      return const Center(child: CircularProgressIndicator());
                    case HomeSuccessState _:
                      if (state.subjectsList.isEmpty) {
                        return const Center(child: Text('No subjects found'));
                      }
                      return ListView.builder(
                        itemCount: state.subjectsList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.subjectDetails,
                                arguments: state.subjectsList[index],
                              );
                            },
                            child: SubjectItem(
                              imageUrl: state.subjectsList[index].icon ,
                              name: state.subjectsList[index].name,
                            ),
                          );
                        },
                      );
                    case HomeErrorState _:
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(state.errorMessage, textAlign: TextAlign.center, style: const TextStyle(color: Colors.red)),
                            verticalSpace(16),
                            ElevatedButton(
                              onPressed: () => homeCubit.getAllSubjects(),
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      );
                    default:
                      return const Center(child: Text('Something went wrong'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
