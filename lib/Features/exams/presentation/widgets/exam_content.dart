import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helper/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/models/exam_questions_response.dart';
import '../manager/exam_veiw_model.dart';
import '../manager/exam_veiw_states.dart';

Widget buildExamContent(BuildContext context, ExamQuestionsResponse? examData, ExamViewModel examViewModel) {
  var theme = Theme.of(context);

  if (examData == null || examData.questions == null || examData.questions!.isEmpty) {
    return const Center(child: Text("No Questions Found"));
  }

  return Padding(
    padding:  EdgeInsets.symmetric(vertical: 16.h , horizontal: 8.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      children: [
        BlocBuilder<ExamViewModel, ExamStates>(
          buildWhen: (previous, current) =>
          previous.currentQuestionIndex != current.currentQuestionIndex,
          builder: (context, state) {
            return Text(
              "Question ${(state.currentQuestionIndex ?? 0) + 1} of ${examData.questions!.length}",
              style: theme.textTheme.titleLarge,
            );
          },
        ),
        FAProgressBar(
          maxValue: examData.questions!.length.toDouble(),
          currentValue: examViewModel.state.currentQuestionIndex!.toDouble() + 1,
          progressColor: AppColors.blue,
          size: 10,
          animatedDuration: const Duration(milliseconds: 500),
          backgroundColor: AppColors.black[AppColors.colorCode10]!,
          borderRadius: BorderRadius.circular(100),
        ),
        verticalSpace(30),
        Expanded(
          child: PageView.builder(
            controller: examViewModel.pageController,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: examData.questions!.length,
            itemBuilder: (context, questionIndex) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    examData.questions![questionIndex].question ?? "",
                    style: theme.textTheme.titleLarge!.copyWith(fontSize: 18),
                  ),
                  Expanded(
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: examData.questions![questionIndex].answers?.length ?? 0,
                      itemBuilder: (context, answerIndex) {
                        return InkWell(
                          overlayColor: const WidgetStatePropertyAll(Colors.transparent),
                          onTap: () {
                            examViewModel.selectedUserAnswer(answerIndex,questionIndex, examData.questions?[questionIndex].Id?? '', examViewModel.answers[questionIndex].key?? '');
                          },
                          child: BlocBuilder<ExamViewModel, ExamStates>(
                            bloc: examViewModel,
                            buildWhen: (previous, current) {
                              return previous.selectedAnswers != current.selectedAnswers;
                            },
                            builder: (context, state) {
                              return Container(

                                key: ValueKey(examData.questions![questionIndex].answers?[answerIndex].key),
                                margin:  EdgeInsets.all(4.r),
                                padding:  EdgeInsets.all(12.r),
                                decoration: BoxDecoration(
                                  color: AppColors.lightBlue,
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 30,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(color: AppColors.blue, width: 2),
                                      ),
                                      child: Center(
                                        child: Container(
                                          width: 10.w,
                                          height: 10.h,
                                          decoration:  BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: examViewModel.state.selectedAnswers?[questionIndex] == answerIndex ? AppColors.blue : AppColors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    horizontalSpace(10),
                                    Expanded(
                                      child: Text(
                                        examData.questions![questionIndex].answers?[answerIndex].answer ?? '',
                                        style: theme.textTheme.bodyMedium!.copyWith(
                                          fontSize: 14.sp,
                                          color: AppColors.blue[AppColors.colorCode90],
                                        ),
                                        overflow: TextOverflow.fade,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        verticalSpace(30),
        Flexible(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  elevation: const WidgetStatePropertyAll(0),
                  overlayColor: const WidgetStatePropertyAll(Colors.transparent),
                  side: const WidgetStatePropertyAll(BorderSide(color: AppColors.blue)),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                  ),
                  backgroundColor: const WidgetStatePropertyAll(AppColors.white),
                  padding: WidgetStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 64.w, vertical: 14.h),
                  ),
                ),
                onPressed: examViewModel.goToPreviousQuestion,
                child: Text("Back", style: theme.textTheme.bodyMedium!.copyWith(color: AppColors.blue)),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  elevation: const WidgetStatePropertyAll(0),
                  overlayColor: const WidgetStatePropertyAll(Colors.transparent),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                  ),
                  padding: WidgetStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 64.w, vertical: 14.h),
                  ),
                ),
                onPressed:() {
                  examViewModel.goToNextQuestion(context);
                },
                child: const Text("Next"),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
