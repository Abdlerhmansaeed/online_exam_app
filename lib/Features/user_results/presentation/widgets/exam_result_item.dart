import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/Features/exams/data/models/exam_result.dart';
import 'package:online_exam_app/Features/user_results/presentation/pages/exam_details_page.dart';
import 'package:online_exam_app/core/helper/spacing.dart';

class ExamResultItem extends StatelessWidget {
  final ExamResult examResult;
  final int resultNumber;
  const ExamResultItem({super.key, required this.examResult, required this.resultNumber});

  @override
  Widget build(BuildContext context) {
    final correctAnswers = _safeIntConversion(examResult.score['correct']) ?? 0;
    final totalQuestionsInExam = examResult.numberOfQuestions;
    String scoreSummary = "$correctAnswers / $totalQuestionsInExam Corrected";
    if (totalQuestionsInExam == 0 && correctAnswers > 0) {
      scoreSummary = "$correctAnswers Corrected";
    } else if (totalQuestionsInExam == 0 && correctAnswers == 0) {
      scoreSummary = "No questions answered or data unavailable";
    }

    // Format timestamp
    final DateTime examDate =
        DateTime.fromMillisecondsSinceEpoch(examResult.timestamp);
    final String formattedDate =
        "${examDate.day}/${examDate.month}/${examDate.year}";
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: ListTile(
        leading: Container(
          width: 48.w,
          height: 48.h,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Center(
            child: Text(
              '#$resultNumber',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),
          ),
        ),
        title: Text(
          examResult.examTitle.isNotEmpty
              ? examResult.examTitle
              : "Exam Result #$resultNumber",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpace(4),
            Text(
              examResult.subjectName.isNotEmpty
                  ? examResult.subjectName
                  : "General Subject",
              style: TextStyle(fontSize: 13.sp, color: Colors.grey[600]),
            ),
            verticalSpace(2),
            Text(
              "${examResult.numberOfQuestions > 0 ? examResult.numberOfQuestions : 'N/A'} Questions | ${examResult.duration > 0 ? examResult.duration : 'N/A'} Minutes",
              style: TextStyle(fontSize: 12.sp, color: Colors.grey[700]),
            ),
            verticalSpace(4),
            Text(
              scoreSummary,
              style: TextStyle(
                fontSize: 13.sp,
                color: Colors.green[700],
                fontWeight: FontWeight.w500,
              ),
            ),
            verticalSpace(2),
            Text(
              "Date: $formattedDate",
              style: TextStyle(fontSize: 11.sp, color: Colors.grey[500]),
            ),
          ],
        ),
        trailing: Icon(Icons.arrow_forward_ios_rounded,
            size: 18.r, color: Colors.grey[400]),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ExamResultDetailsPage(examResult: examResult),
            ),
          );
        },
      ),
    );
  }

//   Map<String, dynamic>? _safeMapConversion(dynamic data) {
//   if (data == null) return null;
//   if (data is Map<String, dynamic>) return data;
//   if (data is Map) {
//     return Map<String, dynamic>.from(data);
//   }
//   return null;
// }

// List<dynamic>? _safeListConversion(dynamic data) {
//   if (data == null) return null;
//   if (data is List<dynamic>) return data;
//   if (data is List) {
//     return List<dynamic>.from(data);
//   }
//   return null;
// }

  int? _safeIntConversion(dynamic data) {
    if (data == null) return null;
    if (data is int) return data;
    if (data is double) return data.toInt();
    if (data is String) return int.tryParse(data);
    return null;
  }
}
