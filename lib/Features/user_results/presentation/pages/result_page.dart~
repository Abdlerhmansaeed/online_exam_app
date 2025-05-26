import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/di/di.dart';
import '../../../../core/routes/app_routes.dart';
import '../manager/user_view_model_cubit.dart';
import '../widgets/cart_widget.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Result",
                style: theme.textTheme.titleMedium!.copyWith(fontSize: 20.sp),
              ),
              BlocProvider(
                create: (context) {
                  var cubit = getIt<UserViewModelCubit>();
                  cubit.getUserResults();
                  return cubit;
                },
                child: BlocBuilder<UserViewModelCubit, UserViewModelState>(
                  builder: (context, state) {
                    if (state is UserViewModelLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is UserViewModelError) {
                      return Center(child: Text(state.errorMessage));
                    }
                    if (state is UserViewModelSuccess) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: state.examsList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.pushReplacementNamed(context, AppRoutes.resultAnswersPage);
                              },
                              child: CartWidget(
                                subjectName: state.examsList[index].title,
                                duration: state.examsList[index].duration,
                                numberOfQuestions: state.examsList[index].numberOfQuestions,
                                quizTitle: state.examsList[index].title,
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return const Center(child: Text("No Data Found"));
                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}