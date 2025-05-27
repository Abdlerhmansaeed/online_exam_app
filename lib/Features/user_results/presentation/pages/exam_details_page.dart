import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/Features/exams/data/models/exam_result.dart';
import 'package:online_exam_app/Features/exams/data/models/question_result.dart';
import 'package:online_exam_app/Features/user_results/presentation/pages/answers_view.dart';
import 'package:online_exam_app/core/app_manger/app_manger.dart';
import 'package:online_exam_app/core/helper/spacing.dart';
import 'package:online_exam_app/core/theme/app_colors.dart';

Widget _buildScoreCard(
    BuildContext context, Map<String, dynamic> score, int totalQuestions) {
  final correctCount = _safeIntConversion(score['correct']) ?? 0;
  final percentage = score['total']?.toString() ?? '0%';
  final displayTotal = totalQuestions > 0 ? totalQuestions : correctCount;

  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(24.r),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [AppColors.blue, AppColors.blue.withOpacity(0.8)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.r),
      boxShadow: [
        BoxShadow(
          offset: const Offset(0, 4),
          blurRadius: 12,
          color: AppColors.blue.withOpacity(0.3),
        ),
      ],
    ),
    child: Column(
      children: [
        Text(
          'Final Score',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
        verticalSpace(16),
        Text(
          '$correctCount / $displayTotal',
          style: TextStyle(
            fontSize: 36.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
        verticalSpace(8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: AppColors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Text(
            percentage,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildStatisticsRow(
    BuildContext context, int correctCount, int wrongCount) {
  return Row(
    children: [
      Expanded(
        child: _buildStatCard(
          'Correct Answers',
          correctCount.toString(),
          Colors.green,
          Icons.check_circle,
        ),
      ),
      horizontalSpace(16),
      Expanded(
        child: _buildStatCard(
          'Wrong Answers',
          wrongCount.toString(),
          Colors.red,
          Icons.cancel,
        ),
      ),
    ],
  );
}

Widget _buildStatCard(String title, String value, Color color, IconData icon) {
  return Container(
    padding: EdgeInsets.all(16.r),
    decoration: BoxDecoration(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(color: color.withOpacity(0.3)),
    ),
    child: Column(
      children: [
        Icon(icon, color: color, size: 32.r),
        verticalSpace(8),
        Text(
          value,
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        verticalSpace(4),
        Text(
          title,
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.grey[600],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget _buildActionButtons(BuildContext context, List<dynamic> correctQuestions,
    List<dynamic> wrongQuestions) {
  return Column(
    children: [
      SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: correctQuestions.isNotEmpty
              ? () =>
                  _navigateToDetailedAnswers(context, correctQuestions, true)
              : null,
          icon: const Icon(Icons.check_circle, color: AppColors.white),
          label: Text(
            'View Correct Answers (${correctQuestions.length})',
            style: TextStyle(color: AppColors.white, fontSize: 14.sp),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            padding: EdgeInsets.symmetric(vertical: 12.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
        ),
      ),
      verticalSpace(12),
      SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: wrongQuestions.isNotEmpty
              ? () => _navigateToDetailedAnswers(context, wrongQuestions, false)
              : null,
          icon: const Icon(Icons.cancel, color: AppColors.white),
          label: Text(
            'View Incorrect Answers (${wrongQuestions.length})',
            style: TextStyle(color: AppColors.white, fontSize: 14.sp),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            padding: EdgeInsets.symmetric(vertical: 12.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
        ),
      ),
    ],
  );
}

void _navigateToDetailedAnswers(
    BuildContext context, List<dynamic> questions, bool isCorrect) {
  try {
    if (questions.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(isCorrect
              ? 'No correct answers to display'
              : 'No wrong answers to display'),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AnswersView(
          questions: questions.cast<QuestionResult>(),
          isCorrect: isCorrect,
        ),
      ),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error: $e'),
      ),
    );
  }
}

Widget _buildBackToHomeButton(BuildContext context) {
  return Center(
    child: OutlinedButton.icon(
      onPressed: () {
        Navigator.pop(context);
        context.read<AppManger>().changeBottomNavBar(0);
      },
      icon: const Icon(Icons.home, color: AppColors.blue),
      label: Text(
        'Finish Reviewing',
        style: TextStyle(color: AppColors.blue, fontSize: 14.sp),
      ),
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: AppColors.blue),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    ),
  );
}

class ExamResultDetailsPage extends StatelessWidget {
  final ExamResult examResult;
  const ExamResultDetailsPage({super.key, required this.examResult});

  @override
  Widget build(BuildContext context) {
    final score = _safeMapConversion(examResult.score) ?? {};
    final correctQuestions =
        _safeListConversion(examResult.correctQuestions) ?? [];
    final wrongQuestions = _safeListConversion(examResult.wrongQuestions) ?? [];
    final correctCount = _safeIntConversion(score['correct']) ?? 0;
    final wrongCount = _safeIntConversion(score['wrong']) ?? 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          examResult.examTitle.isNotEmpty
              ? examResult.examTitle
              : "Exam Details",
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [
            _buildScoreCard(context, score, examResult.numberOfQuestions),
            verticalSpace(24),
            _buildStatisticsRow(context, correctCount, wrongCount),
            verticalSpace(32),
            _buildActionButtons(context, correctQuestions, wrongQuestions),
            verticalSpace(32),
            _buildBackToHomeButton(context),
          ],
        ),
      ),
    );
  }
}

Map<String, dynamic>? _safeMapConversion(dynamic data) {
  if (data == null) return null;
  if (data is Map<String, dynamic>) return data;
  if (data is Map) {
    return Map<String, dynamic>.from(data);
  }
  return null;
}

List<dynamic>? _safeListConversion(dynamic data) {
  if (data == null) return null;
  if (data is List<dynamic>) return data;
  if (data is List) {
    return List<dynamic>.from(data);
  }
  return null;
}

int? _safeIntConversion(dynamic data) {
  if (data == null) return null;
  if (data is int) return data;
  if (data is double) return data.toInt();
  if (data is String) return int.tryParse(data);
  return null;
}
