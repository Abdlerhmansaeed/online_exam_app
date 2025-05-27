import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/Features/exams/data/models/question_result.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/helper/spacing.dart';

class AnswersCardWidget extends StatelessWidget {
  final QuestionResult question;
  final bool isCorrect;
  final int questionNumber;

  const AnswersCardWidget({
    super.key,
    required this.question,
    required this.isCorrect,
    required this.questionNumber,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    final questionText = question.questionText;
    final correctAnswer = question.correctAnswer;
    final userAnswer = question.userAnswer ?? '';
    final allAnswers = question.allAnswers;

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isCorrect
              ? Colors.green.withOpacity(0.3)
              : Colors.red.withOpacity(0.3),
          width: 1.w,
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 2),
            blurRadius: 8,
            color: Colors.black.withOpacity(0.1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 28.w,
                height: 28.h,
                decoration: BoxDecoration(
                  color: isCorrect ? Colors.green : Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '$questionNumber',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              horizontalSpace(12),
              Expanded(
                child: Text(
                  questionText,
                  style: theme.textTheme.bodyLarge!.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
              ),
            ],
          ),

          verticalSpace(16),

          ...allAnswers.map((option) {
            final answerKey = option.key;
            final answerText = option.text;
            final isUserSelected = answerKey == userAnswer;
            final isCorrectAnswer = answerKey == correctAnswer;

            Color bgColor = AppColors.lightBlue;
            Color borderColor = Colors.transparent;
            IconData? icon;
            Color iconColor = AppColors.blue;

            if (isCorrectAnswer) {
              bgColor = AppColors.lightGreen;
              borderColor = Colors.green;
              icon = Icons.check_circle;
              iconColor = Colors.green;
            }

            if (isUserSelected && !isCorrectAnswer) {
              bgColor = Colors.red.withOpacity(0.1);
              borderColor = Colors.red;
              icon = Icons.cancel;
              iconColor = Colors.red;
            }

            return Container(
              margin: EdgeInsets.only(bottom: 8.h),
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(12.r),
                border: borderColor != Colors.transparent
                    ? Border.all(color: borderColor, width: 1.w)
                    : null,
              ),
              child: Row(
                children: [
                  Container(
                    width: 24.w,
                    height: 24.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: iconColor,
                        width: 2.w,
                      ),
                      color: icon != null
                          ? iconColor.withOpacity(0.2)
                          : Colors.transparent,
                    ),
                    child: icon != null
                        ? Icon(icon, color: iconColor, size: 16.r)
                        : Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.grey, width: 2.w),
                            ),
                          ),
                  ),

                  horizontalSpace(12),

                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '$answerKey. ',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: iconColor != AppColors.blue
                                  ? iconColor
                                  : AppColors.black,
                            ),
                          ),
                          TextSpan(
                            text: answerText,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.blue[AppColors.colorCode90],
                              fontWeight: isUserSelected || isCorrectAnswer
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
