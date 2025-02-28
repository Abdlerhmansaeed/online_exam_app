import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/routes/app_routes.dart';

import '../../../../core/helper/spacing.dart';
import '../../../../core/theme/app_colors.dart';

class ResultCartWidget extends StatelessWidget {
  const ResultCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalSpace(40),
        Text(
          "Language",
          style: theme.textTheme.labelLarge!.copyWith(fontSize: 18.sp),
        ),
        verticalSpace(24),
        InkWell(
          onTap: () {
            Navigator.pushReplacementNamed(
                context, AppRoutes.resultAnswersPage);
          },
          hoverColor: Colors.transparent,
          child: Container(
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
                      "High level",
                      style: theme.textTheme.bodySmall!.copyWith(
                        color: AppColors.black,
                        fontSize: 16.sp,
                      ),
                    ),
                    const Text(
                      "20 Question",
                      style: TextStyle(
                        color: AppColors.gray,
                      ),
                    ),
                    verticalSpace(16),
                    Text(
                      "18 corrected answers in 25 min.",
                      style: theme.textTheme.bodySmall!.copyWith(
                        color: AppColors.blue,
                      ),
                    ),
                  ],
                ),
                const Text("30 Minutes"),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
