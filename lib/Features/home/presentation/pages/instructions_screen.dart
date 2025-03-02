import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/helper/spacing.dart';
import 'package:online_exam_app/core/routes/app_routes.dart';
import 'package:online_exam_app/core/theme/app_colors.dart';

class ExamInstructionsScreen extends StatelessWidget {
  String? subjectName;
  int? duration;
  int? numberOfQuestions;
  String? createdAt;
  String?quizTitle;
ExamInstructionsScreen({
  this.subjectName,
  this.duration,
  this.numberOfQuestions,
  this.createdAt,
  this.quizTitle
});
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset("assets/images/Profit.png"),
                horizontalSpace(40),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subjectName ?? "Languages",
                      style: TextStyle(color: AppColors.blue[60]),
                    ),
                    horizontalSpace(10),
                    Text(" $numberOfQuestions Questions", ),
                  ],
                ),
                Spacer(),
                Text(
                  "$duration Minutes",
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppColors.blue[60],
                  ),
                ),
              ],
            ),
           verticalSpace(20),
            Text(
              "Instructions",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            verticalSpace(20),
            ...[  
              "Read all questions carefully before answering.",
              "Choose the correct answer before proceeding to the next question.",
              "Ensure your internet connection is stable.",
              "Do not exit the exam before submitting your answers.",
            ].map((instruction) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.black,
                        radius: 5.r,
                        ),
                      horizontalSpace(8),
                      Expanded(child: Text(instruction)),
                    ],
                  ),
                )),
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
                  // Navigator.pushNamed(
                  //  context,
                  //  AppRoutes.resultAnswersPage 
                  // );
                },
                child: Text("Start", style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
