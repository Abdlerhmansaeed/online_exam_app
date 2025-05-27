import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/Features/exams/data/models/exam_result.dart';
import 'package:online_exam_app/Features/user_results/presentation/widgets/exam_result_item.dart';

class ExamResultsListView extends StatelessWidget {
 final List<ExamResult> examResults;
  const ExamResultsListView({super.key, required this.examResults});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
          child: Text(
            "All Exam Results (${examResults.length})",
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: examResults.length,
            itemBuilder: (context, index) {
              final examResult = examResults[index];
              return ExamResultItem(
                examResult: examResult,
                resultNumber: index + 1,
              );
            },
          ),
        ),
      ],
    );
  }
}
