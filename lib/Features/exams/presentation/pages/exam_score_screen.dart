import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/Features/exams/presentation/manager/exam_veiw_states.dart';
import 'package:online_exam_app/core/base_states/base_states.dart';
import 'package:online_exam_app/core/helper/spacing.dart';
import 'package:online_exam_app/core/routes/app_routes.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/models/check_questions_response.dart';
import '../manager/exam_veiw_model.dart';

class ExamScoreScreen extends StatelessWidget {
  const ExamScoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var viewModel = ModalRoute.of(context)?.settings.arguments as ExamViewModel;

    return BlocProvider(
      create: (context) => viewModel,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Exam Score",
            style: theme.textTheme.titleMedium!.copyWith(
              fontSize: 20.sp,
            ),
          ),
          leading: GestureDetector(
              onTap: () {
                viewModel.navigateToRoute(routeName: AppRoutes.layoutScreen, context: context);
              },
              child: Icon(Icons.arrow_back_ios_new_rounded)),
        ),
        body: BlocBuilder<ExamViewModel, ExamStates>(
          builder: (context, state) {

            final viewModel = context.read<ExamViewModel>();
            if (state.checkUserAnswersStates is SuccessState<CheckQuestionsResponse>) {
              var data = (state.checkUserAnswersStates as SuccessState<CheckQuestionsResponse>).data;
              final totalString = data?.total?.replaceAll('%', '') ?? '0';
              final total = double.tryParse(totalString) ?? 0.0;
              final percentage = total.toStringAsFixed(1);
              return Padding(
                padding: EdgeInsets.all(16.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your Score",
                      style: theme.textTheme.titleLarge!.copyWith(
                        fontSize: 20.sp,
                      ),
                    ),
                    verticalSpace(16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircularPercentIndicator(
                          radius: MediaQuery.of(context).size.width * 0.2,
                          lineWidth: 10.0,
                          backgroundColor: AppColors.red,
                          percent: total/100,
                          center: Text(
                            "$percentage%"
                            ,
                            style: theme.textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          progressColor: AppColors.blue,
                        ),
                        horizontalSpace(10),
                        Expanded(
                          child: Column(
                            children: [
                              _buildScoreRow("Correct", AppColors.blue, "${data?.correct?? ''}"),
                              _buildScoreRow("Incorrect", AppColors.red, "${data?.wrong?? ''}"),
                            ],
                          ),
                        ),
                      ],
                    ),
                    verticalSpace(32),
                    Center(child: _buildButton("Show Results", () {})),
                    verticalSpace(24),
                    Center(child: _buildButton("Start Again", () {}, isPrimary: false)),
                  ],
                ),
              );
            }
            else if (state.checkUserAnswersStates is ErrorState) {
              return  Center(
                child: Text((state.checkUserAnswersStates as ErrorState).error?? "Error Occurred"),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget _buildScoreRow(String label, Color color, String value) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16.sp, color: color, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        Container(
          width: 25.w,
          height: 25.h,
          margin: EdgeInsets.all(4.r),
          padding: EdgeInsets.all(4.r),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 1.4.w),
          ),
          child: Center(child: Text(value, style: TextStyle(color: color, fontSize: 14.sp, fontWeight: FontWeight.bold))),
        ),
      ],
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed, {bool isPrimary = true}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: isPrimary
            ? null
            : const WidgetStatePropertyAll(AppColors.white),
        side: isPrimary
            ? null
            : WidgetStatePropertyAll(
            BorderSide(color: AppColors.blue, width: 1.1.w),),
        elevation: const WidgetStatePropertyAll(0),
        overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(8.r),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: isPrimary ? null : AppColors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
