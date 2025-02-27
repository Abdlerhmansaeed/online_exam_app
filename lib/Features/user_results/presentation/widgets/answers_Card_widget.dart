import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

class AnswersCardWidget extends StatelessWidget {
  const AnswersCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var theme= Theme.of(context);
    return  Container(
      margin: EdgeInsets.symmetric(vertical: 16.h,horizontal: 12.w),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: const [
          BoxShadow(
            offset: Offset(2, 2),
            blurRadius: 12,
            color: Color.fromRGBO(0, 0, 0, 0.16),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select the correctly punctuated \nsentence.",
            textAlign: TextAlign.start,
            style: theme.textTheme.labelLarge!.copyWith(fontSize: 18.sp),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
                color: AppColors.lightGreen,
                borderRadius: BorderRadius.circular(16.r)),
            child: Row(
              children: [
                Checkbox(
                  value: true,
                  checkColor: AppColors.green,
                  fillColor: WidgetStatePropertyAll(AppColors.green),
                  shape: CircleBorder(),
                  onChanged: (value) {},
                ),
                Text(
                  "Its going to rain today.",
                  style: theme.textTheme.bodyMedium!.copyWith(
                    fontSize: 14.sp,
                    color: AppColors.blue[AppColors.colorCode90],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
                color: AppColors.lightBlue,
                borderRadius: BorderRadius.circular(16.r)),
            child: Row(
              children: [
                Checkbox(
                  value: true,
                  shape: CircleBorder(),
                  onChanged: (value) {},
                ),
                Text(
                  "Its going to rain today.",
                  style: theme.textTheme.bodyMedium!.copyWith(
                    fontSize: 14.sp,
                    color: AppColors.blue[AppColors.colorCode90],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
                color: AppColors.lightBlue,
                borderRadius: BorderRadius.circular(16.r)),
            child: Row(
              children: [
                Checkbox(
                  value: true,
                  shape: CircleBorder(),
                  onChanged: (value) {},
                ),
                Text(
                  "Its going to rain today.",
                  style: theme.textTheme.bodyMedium!.copyWith(
                    fontSize: 14.sp,
                    color: AppColors.blue[AppColors.colorCode90],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
                color: AppColors.lightBlue,
                borderRadius: BorderRadius.circular(16.r)),
            child: Row(
              children: [
                Checkbox(
                  value: true,
                  shape: CircleBorder(),
                  onChanged: (value) {},
                ),
                Text(
                  "Its going to rain today.",
                  style: theme.textTheme.bodyMedium!.copyWith(
                    fontSize: 14.sp,
                    color: AppColors.blue[AppColors.colorCode90],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
