import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/Features/exams/presentation/pages/exam_screen.dart';
import 'package:online_exam_app/Features/main_layout/Ui/layout_screen.dart';
import 'package:online_exam_app/core/helper/spacing.dart';
import 'package:online_exam_app/core/theme/app_colors.dart';

import '../../../../core/generated/assets.dart';

class ExamInstructionsScreen extends StatelessWidget {
  final String? subjectName;
  final int? duration;
  final int? numberOfQuestions;
  final String? createdAt;
  final String? quizTitle;
  final String? examId;

  const ExamInstructionsScreen({
    super.key,
    this.subjectName,
    this.duration,
    this.numberOfQuestions,
    this.createdAt,
    this.quizTitle,
    this.examId,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: const Icon(Icons.arrow_back),
          onTap: () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LayoutScreen()),
            (route) => false,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(Assets.imagesProfit),
                horizontalSpace(40),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      quizTitle ?? "Languages",
                      style: TextStyle(color: AppColors.blue[60]),
                    ),
                    horizontalSpace(10),
                    Text(
                      " $numberOfQuestions Questions",
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  "$duration Minutes",
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppColors.blue[60],
                      ),
                ),
              ],
            ),
            verticalSpace(20),
            const Text(
              "Instructions",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            verticalSpace(20),
            ...[
              "Read all questions carefully before answering.",
              "Choose the correct answer before proceeding to the next question.",
              "Ensure your internet connection is stable.",
              "Do not exit the exam before submitting your answers.",
            ].map(
              (instruction) => Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.black,
                    radius: 2.r,
                  ),
                  horizontalSpace(8),
                  Expanded(child: Text(instruction)),
                ],
              ),
            ),
            verticalSpace(40),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 80.w, vertical: 15),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ExamScreen(
                        duration: duration,
                        examId: examId ?? '',
                        examTitle: quizTitle ?? "Unknown Exam",
                        subjectName: subjectName ?? "Unknown Subject",
                        numberOfQuestions: numberOfQuestions ?? 0,
                        examDuration: duration ?? 0,
                      ),
                    ),
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Start", style: TextStyle(fontSize: 18)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
