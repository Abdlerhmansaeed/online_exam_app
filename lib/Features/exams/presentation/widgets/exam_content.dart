import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/routes/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/models/exam_questions_response.dart';
import '../manager/exam_veiw_model.dart';
import '../manager/exam_states.dart';

class ExamContentScreen extends StatelessWidget {
  final ExamQuestionsResponse? examData;
  final ExamViewModel examViewModel;

  const ExamContentScreen({
    super.key,
    required this.examData,
    required this.examViewModel,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    if (examData == null ||
        examData!.questions == null ||
        examData!.questions!.isEmpty) {
      return const Center(child: Text("No Questions Found"));
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildQuestionHeader(context, theme),

          Expanded(
            child: _buildQuestionContent(context, theme),
          ),

          _buildNavigationButtons(context, theme),
        ],
      ),
    );
  }
  Widget _buildQuestionHeader(BuildContext context, ThemeData theme) {
    return Column(
      children: [
        BlocBuilder<ExamViewModel, ExamStates>(
          buildWhen: (previous, current) =>
              previous.currentQuestionIndex != current.currentQuestionIndex,
          builder: (context, state) {
            return Text(
              "Question ${(state.currentQuestionIndex?? 0) + 1} of ${examData!.questions!.length}",
              style: theme.textTheme.titleLarge,
            );
          },
        ),
        SizedBox(height: 8.h),
        FAProgressBar(
          maxValue: examData!.questions!.length.toDouble(),
          currentValue:
              examViewModel.state.currentQuestionIndex?.toDouble()?? 0.0 + 1,
          progressColor: AppColors.blue,
          size: 8,
          animatedDuration: const Duration(milliseconds: 300),
          backgroundColor: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(100),
        ),
      ],
    );
  }

  Widget _buildQuestionContent(BuildContext context, ThemeData theme) {
    return PageView.builder(
      controller: examViewModel.pageController,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: examData!.questions!.length,
      itemBuilder: (context, questionIndex) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24.h),
            Text(
              examData!.questions![questionIndex].question ?? "",
              style: theme.textTheme.titleMedium?.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount:
                    examData!.questions![questionIndex].answers?.length ?? 0,
                itemBuilder: (context, answerIndex) {
                  return _buildAnswerOption(
                    context,
                    theme,
                    questionIndex,
                    answerIndex,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAnswerOption(
    BuildContext context,
    ThemeData theme,
    int questionIndex,
    int answerIndex,
  ) {
    return InkWell(
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      onTap: () => examViewModel.selectAnswer(questionIndex, answerIndex),
      child: BlocBuilder<ExamViewModel, ExamStates>(
        bloc: examViewModel,
        buildWhen: (previous, current) {
          return previous.selectedAnswers != current.selectedAnswers;
        },
        builder: (context, state) {
          final isSelected =
              examViewModel.state.selectedAnswers[questionIndex] ==
                  answerIndex;

          return Container(
            key: ValueKey(
                examData!.questions![questionIndex].answers?[answerIndex].key),
            margin: EdgeInsets.only(bottom: 12.h),
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: isSelected ? AppColors.blue : Colors.grey.shade200,
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 24.w,
                  height: 24.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? AppColors.blue : Colors.grey.shade400,
                      width: 2,
                    ),
                  ),
                  child: isSelected
                      ? Center(
                          child: Container(
                            width: 12.w,
                            height: 12.h,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.blue,
                            ),
                          ),
                        )
                      : null,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    examData!.questions![questionIndex].answers?[answerIndex]
                            .answer ??
                        '',
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.black87,
                      fontWeight:
                          isSelected ? FontWeight.w500 : FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildNavigationButtons(BuildContext context, ThemeData theme) {
    final isLastQuestion = examViewModel.state.currentQuestionIndex ==
        (examData!.questions?.length ?? 0) - 1;

    final isFirstQuestion = examViewModel.state.currentQuestionIndex == 0;

    return Row(
      children: [
        Expanded(
          child: Container(
            height: 48.h,
            margin: EdgeInsets.only(right: 8.w),
            child: OutlinedButton(
              onPressed:
                  isFirstQuestion ? null : examViewModel.goToPreviousQuestion,
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppColors.blue,
                side: BorderSide(
                  color:
                      isFirstQuestion ? Colors.grey.shade300 : AppColors.blue,
                  width: 1.5,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                disabledForegroundColor: Colors.grey.shade400,
                disabledBackgroundColor: Colors.grey.shade100,
              ),
              child: Text(
                "Back",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color:
                      isFirstQuestion ? Colors.grey.shade400 : AppColors.blue,
                ),
              ),
            ),
          ),
        ),

        Expanded(
          child: Container(
            height: 48.h,
            margin: EdgeInsets.only(left: 8.w),
            child: ElevatedButton(
              onPressed: () {
                if (isLastQuestion) {
                  _submitAnswersAndShowResults(context);
                } else {
                  examViewModel.goToNextQuestion(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                elevation: 0,
              ),
              child: _buildNextButtonContent(isLastQuestion),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNextButtonContent(bool isLastQuestion) {
    return examViewModel.state.checkUserAnswersStates?.maybeWhen(
          loading: () => const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,
            ),
          ),
          orElse: () => Text(
            isLastQuestion ? "Finish" : "Next",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ) ??
        Text(
          isLastQuestion ? "Finish" : "Next",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        );
  }

  void _submitAnswersAndShowResults(BuildContext context) async {
    examViewModel.cancelTimer();
    await examViewModel.checkUserAnswers();
    examViewModel.navigateToRoute(
      routeName: AppRoutes.examScoreScreen,
      context: context,
      arguments: examViewModel,
    );
  }
}

Widget buildExamContent(BuildContext context, ExamQuestionsResponse? examData,
    ExamViewModel examViewModel) {
  return ExamContentScreen(
    examData: examData,
    examViewModel: examViewModel,
  );
}
