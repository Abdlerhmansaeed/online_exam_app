import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/Features/user_results/presentation/widgets/error_view.dart';
import 'package:online_exam_app/Features/user_results/presentation/widgets/exam_results_list_view.dart';
import 'package:online_exam_app/Features/user_results/presentation/widgets/full_back_view_widget.dart';
import 'package:online_exam_app/Features/user_results/presentation/widgets/no_data_view_widget.dart';
import 'package:online_exam_app/core/app_manger/app_manger.dart';
import '../../../../core/di/di.dart';
import '../manager/user_view_model_cubit.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocProvider(
      create: (context) {
        var cubit = getIt<UserViewModelCubit>();
        cubit.getAllExamResults();
        return cubit;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Exam Results",
              style: theme.textTheme.titleLarge,
            ),
            leading: IconButton(
              onPressed: () => context.read<AppManger>().changeBottomNavBar(0),
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(16.r),
            child: BlocBuilder<UserViewModelCubit, UserViewModelState>(
              builder: (context, state) {
                if (state is ExamResultsLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is ExamResultsEmpty) {
                  return const NoDataViewWidget();
                }

                if (state is ExamResultsError) {
                  return ErrorView(errorMessage: state.errorMessage);
                }

                if (state is ExamResultsSuccess) {
                  final examResultsList = state.examResults;

                  if (examResultsList.isEmpty) {
                    return const NoDataViewWidget();
                  }

                  return ExamResultsListView(examResults: state.examResults);
                }

                return const FullBackViewWidget();
              },
            ),
          ),
        ),
      ),
    );
  }
}
