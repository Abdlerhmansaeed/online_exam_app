import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/Features/exams/presentation/manager/exam_states.dart';
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

    return BlocProvider.value(
      value: viewModel,
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
                viewModel.navigateToRoute(
                    routeName: AppRoutes.layoutScreen, context: context);
              },
              child: const Icon(Icons.arrow_back_ios_new_rounded)),
        ),
        body: BlocBuilder<ExamViewModel, ExamStates>(
          builder: (context, state) {
            return state.checkUserAnswersStates?.maybeWhen(
                  initial: () {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  loading: () {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  success: (data) {
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
                                percent: total / 100,
                                center: Text(
                                  "$percentage%",
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
                                    _buildScoreRow("Correct", AppColors.blue,
                                        "${data?.correct ?? ''}"),
                                    _buildScoreRow("Incorrect", AppColors.red,
                                        "${data?.wrong ?? ''}"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          verticalSpace(32),
                          Center(
                            child: _buildButton("Show Results", () {
                              _showResultDetails(context, data);
                            }),
                          ),
                          verticalSpace(24),
                          Center(
                              child: _buildButton("Start Again", () {
                            Navigator.pushNamedAndRemoveUntil(context,
                                AppRoutes.layoutScreen, (route) => false);
                          }, isPrimary: false)),
                        ],
                      ),
                    );
                  },
                  error: (error) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            error ?? "Error occurred",
                            style: theme.textTheme.titleLarge,
                            textAlign: TextAlign.center,
                          ),
                          verticalSpace(20),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                AppRoutes.layoutScreen,
                                (route) => false,
                              );
                            },
                            child: const Text("Return to Home"),
                          ),
                        ],
                      ),
                    );
                  },
                  orElse: () {
                    return const Center(
                      child: Text("No data available"),
                    );
                  },
                ) ??
                const Center(child: Text("No data available"));
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
          style: TextStyle(
              fontSize: 16.sp, color: color, fontWeight: FontWeight.bold),
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
          child: Center(
              child: Text(value,
                  style: TextStyle(
                      color: color,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold))),
        ),
      ],
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed,
      {bool isPrimary = true}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor:
            isPrimary ? null : const WidgetStatePropertyAll(AppColors.white),
        side: isPrimary
            ? null
            : WidgetStatePropertyAll(
                BorderSide(color: AppColors.blue, width: 1.1.w),
              ),
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

  void _showResultDetails(BuildContext context, CheckQuestionsResponse? data) {
    if (data == null) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        expand: false,
        builder: (_, scrollController) => ListView(
          controller: scrollController,
          padding: EdgeInsets.all(16.r),
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 5.h,
                margin: EdgeInsets.only(bottom: 16.h),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ),
            if (data.correctQuestions != null &&
                data.correctQuestions!.isNotEmpty) ...[
              Text(
                "Correct Answers (${data.correct ?? 0})",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: AppColors.blue,
                    ),
              ),
              verticalSpace(8),
              ...data.correctQuestions!.map((question) {
                final questionMap = question as Map<String, dynamic>;
                final questionText = questionMap['Question']?.toString() ?? '';
                final correctAnswer =
                    questionMap['correctAnswer']?.toString() ?? '-';

                return _buildQuestionItem(
                  question: questionText,
                  isCorrect: true,
                  correctAnswer: correctAnswer,
                );
              }),
            ],
            if (data.WrongQuestions != null &&
                data.WrongQuestions!.isNotEmpty) ...[
              verticalSpace(24),
              Text(
                "Wrong Answers (${data.wrong ?? 0})",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: AppColors.red,
                    ),
              ),
              verticalSpace(8),
              ...data.WrongQuestions!.map((question) {
                final questionMap = question as Map<String, dynamic>;
                final questionText = questionMap['Question']?.toString() ?? '';
                final correctAnswer =
                    questionMap['correctAnswer']?.toString() ?? '-';
                final wrongAnswer =
                    questionMap['inCorrectAnswer']?.toString() ?? '-';

                return _buildQuestionItem(
                  question: questionText,
                  isCorrect: false,
                  correctAnswer: correctAnswer,
                  wrongAnswer: wrongAnswer,
                );
              }),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.layoutScreen,
                    (route) => false,
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Back to Home Page"),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionItem({
    required String question,
    required bool isCorrect,
    required String correctAnswer,
    String? wrongAnswer,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: isCorrect
            ? Colors.green.withOpacity(0.1)
            : Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: isCorrect ? AppColors.blue : AppColors.red,
          width: 1.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (!isCorrect && wrongAnswer != null) ...[
            verticalSpace(4),
            Row(
              children: [
                const Text(
                  "Your Answer: ",
                  style: TextStyle(
                    color: AppColors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(wrongAnswer),
              ],
            ),
          ],
          verticalSpace(4),
          Row(
            children: [
              const Text(
                "Correct Answer: ",
                style: TextStyle(
                  color: AppColors.blue,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(correctAnswer),
            ],
          ),
        ],
      ),
    );
  }
}
