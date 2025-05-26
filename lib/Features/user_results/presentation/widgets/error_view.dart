import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/Features/user_results/presentation/manager/user_view_model_cubit.dart';
import 'package:online_exam_app/core/app_manger/app_manger.dart';
import 'package:online_exam_app/core/helper/spacing.dart';
import 'package:online_exam_app/core/theme/app_colors.dart';

class ErrorView extends StatelessWidget {
  final String errorMessage;
  const ErrorView({super.key, required this.errorMessage});

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
              color: Colors.red.withOpacity(0.1),
            ),
            child: Icon(
              Icons.error_outline,
              size: 64.r,
              color: Colors.red,
            ),
          ),
          verticalSpace(24),
          Text(
            'Something Went Wrong',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          verticalSpace(12),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[600],
                height: 1.5,
              ),
            ),
          ),
          verticalSpace(32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  context.read<UserViewModelCubit>().getAllExamResults();
                },
                icon: const Icon(Icons.refresh, color: AppColors.white),
                label: const Text(
                  'Try Again',
                  style: TextStyle(color: AppColors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.blue,
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
              horizontalSpace(16),
              OutlinedButton.icon(
                onPressed: () {
                  context.read<AppManger>().changeBottomNavBar(0);
                },
                icon: const Icon(Icons.home, color: AppColors.blue),
                label: const Text(
                  'Go Home',
                  style: TextStyle(color: AppColors.blue),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.blue),
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}