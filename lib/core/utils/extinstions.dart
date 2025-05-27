import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/theme/app_colors.dart';

extension BuildContextExtension on BuildContext {
  double get height => MediaQuery.sizeOf(this).height;
  double get width => MediaQuery.sizeOf(this).width;
  ThemeData get theme => Theme.of(this);
}

extension DialogExtensions on BuildContext {
  Future<T?> showErrorDialog<T>(
          String? errorMessage, BuildContext dialogContext) =>
      showDialog<T>(
        barrierDismissible: false,
        context: dialogContext,
        builder: (context) {
          return AlertDialog(
            backgroundColor: AppColors.white.withOpacity(0.9),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.error_outline_rounded,
                  color: Colors.red,
                  size: 50.w,
                ),
                SizedBox(height: 16.h),
                Text(
                  errorMessage ?? "An error occurred",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 16.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blue,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text('OK'),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
}
