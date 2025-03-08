import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/helper/spacing.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../core/theme/app_colors.dart';

class ExamScoreScreen extends StatelessWidget {
  const ExamScoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Exam Score",
          style: theme.textTheme.titleMedium!.copyWith(
            fontSize: 20.sp,
          ),
        ),
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_back_ios_new_rounded)),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0.r),
        children: [ Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your Score",
              style: theme.textTheme.titleLarge!.copyWith(
                fontSize: 18.sp,
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

                  center: Text("20", style: theme.textTheme.titleLarge,),
                  progressColor: AppColors.blue,
                ),
                horizontalSpace(10),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Correct",
                            style: theme.textTheme.bodyMedium!.copyWith(
                              fontSize: 16.sp,
                              color: AppColors.blue,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.all(4.r),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.blue),
                            ),
                            child: Text(
                              "1",
                              style: TextStyle(color: AppColors.blue),
                            ),
                          ),
                        ],
                      ),
                      Row(
                  
                        children: [
                          Text(
                            "Incorrect",
                            style: theme.textTheme.bodyMedium!.copyWith(
                              fontSize: 16.sp,
                              color: AppColors.red,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.all(4.r),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.red),
                            ),
                            child: Text(
                              "1",
                              style: TextStyle(color: AppColors.red),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            verticalSpace(32),
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                padding: WidgetStatePropertyAll(EdgeInsets.all(16.r)),
                elevation: const WidgetStatePropertyAll(0),
                overlayColor: const WidgetStatePropertyAll(Colors.transparent),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Show Results"),
                ],
              ),
            ),
            verticalSpace(24),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: const WidgetStatePropertyAll(AppColors.white),
                side: WidgetStatePropertyAll(
                    BorderSide(color: AppColors.blue, width: 1.2.w)),
                overlayColor: const WidgetStatePropertyAll(Colors.transparent),
                elevation: const WidgetStatePropertyAll(0),
                foregroundColor:const WidgetStatePropertyAll(AppColors.blue),

                padding: WidgetStatePropertyAll(EdgeInsets.all(16.r)),
              ),
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Start Again",
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: AppColors.blue,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
