import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/routes/app_routes.dart';

import '../../../../core/helper/spacing.dart';
import '../../../../core/theme/app_colors.dart';

class CartWidget extends StatelessWidget {
  String? subjectName;
  int? duration;
  int? numberOfQuestions;
  String? createdAt;
  String?quizTitle;

 
   CartWidget({super.key,
   this.subjectName,
   this.duration,
   this.numberOfQuestions,
   this.createdAt,
   this.quizTitle
   });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalSpace(40),
        Text(
         subjectName ?? "Language",
          style: theme.textTheme.labelLarge!.copyWith(fontSize: 18.sp),
        ),
        verticalSpace(24),
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 24,
          ),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: const [
              BoxShadow(
                offset: Offset(2, 2),
                blurRadius: 12,
                color: Color.fromRGBO(0, 0, 0, 0.16),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("assets/images/Profit.png"),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                     quizTitle??"High level",
                    style: theme.textTheme.bodySmall!.copyWith(
                      color: AppColors.black,
                      fontSize: 16.sp,
                    ),
                  ),
                   Text(
                   "${numberOfQuestions.toString()} Question" ?? "20 Question",
                    style: TextStyle(
                      color: AppColors.blue[60],
                    ),
                  ),
                  verticalSpace(16),
                  Text(
                  createdAt ??  "18 corrected answers in 25 min.",
                    style: theme.textTheme.bodySmall!.copyWith(
                      color: AppColors.blue,
                    ),
                  ),
                ],
              ),
               Text( "${duration.toString()} Minutes" ?? "30 Minutes"),
            ],
          ),
        ),
      ],
    );
  }
}
