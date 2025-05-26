import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/app_manger/app_manger.dart';
import 'package:online_exam_app/core/helper/spacing.dart';

class FullBackViewWidget extends StatelessWidget {
  const FullBackViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.quiz_outlined,
            size: 64.r,
            color: Colors.grey,
          ),
          verticalSpace(16),
          Text(
            'No Exam Results',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          verticalSpace(8),
          Text(
            'You haven\'t taken any exam yet.',
            style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
          ),
          verticalSpace(24),
          ElevatedButton(
            onPressed: () => context.read<AppManger>().changeBottomNavBar(0),
            child: const Text('Back to Home'),
          ),
        ],
      ),
    );;
  }
}