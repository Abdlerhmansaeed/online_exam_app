// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/theme/app_colors.dart';
import 'package:online_exam_app/core/utils/extinstions.dart';

class AnswersContainer extends StatelessWidget {
  final String? question;
  bool? checkboxValue;
  AnswersContainer({super.key, this.question, this.checkboxValue});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.lightBlue,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Checkbox(
            value: checkboxValue,
            shape: const CircleBorder(),
            onChanged: (value) {
              checkboxValue = value;
            },
          ),
          Text(
            question ?? '',
            style:
                context.theme.textTheme.labelLarge!.copyWith(fontSize: 16.sp),
          ),
        ],
      ),
    );
  }
}
