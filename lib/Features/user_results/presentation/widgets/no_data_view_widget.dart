import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/app_manger/app_manger.dart';
import 'package:online_exam_app/core/helper/spacing.dart';
import 'package:online_exam_app/core/theme/app_colors.dart';

class NoDataViewWidget extends StatelessWidget {
  const NoDataViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120.w,
            height: 120.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.blue.withOpacity(0.1),
            ),
            child: Icon(
              Icons.quiz_outlined,
              size: 64.r,
              color: AppColors.blue.withOpacity(0.6),
            ),
          ),
          verticalSpace(24),
          Text(
            'No Exam Results Yet',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.blue,
            ),
          ),
          verticalSpace(12),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Text(
              'No exam results found. Start a new exam to see your results here.',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[600],
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          verticalSpace(32),
          SizedBox(
            width: 200.w,
            child: ElevatedButton.icon(
              onPressed: () {
                context.read<AppManger>().changeBottomNavBar(0);
              },
              icon: const Icon(Icons.home, color: AppColors.white),
              label: const Text(
                'Start New Exam',
                style: TextStyle(
                    color: AppColors.white, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.blue,
                padding: EdgeInsets.symmetric(vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.r),
                ),
                elevation: 3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}