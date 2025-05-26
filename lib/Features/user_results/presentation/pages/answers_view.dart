import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/Features/exams/data/models/question_result.dart';

import '../../../../core/helper/spacing.dart';
import '../widgets/answers_Card_widget.dart';

class AnswersView extends StatelessWidget {
  final List<QuestionResult> questions;
  final bool isCorrect;

  const AnswersView({
    super.key,
    required this.questions,
    required this.isCorrect,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isCorrect ? 'Correct Answers' : 'Incorrect Answers',
          style: TextStyle(
            color: isCorrect ? Colors.green : Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        backgroundColor:
            (isCorrect ? Colors.green : Colors.red).withOpacity(0.1),
        elevation: 0,
      ),
      body: Column(
        children: [
          // شريط الإحصائيات
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.r),
            color: (isCorrect ? Colors.green : Colors.red).withOpacity(0.1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isCorrect ? Icons.check_circle : Icons.cancel,
                  color: isCorrect ? Colors.green : Colors.red,
                  size: 24.r,
                ),
                horizontalSpace(8),
                Text(
                  '${questions.length} ${isCorrect ? 'Correct' : 'Incorrect'}',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: isCorrect ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16.r),
              itemCount: questions.length,
              itemBuilder: (context, index) {
                final question = questions[index];
                return AnswersCardWidget(
                  question: question,
                  isCorrect: isCorrect,
                  questionNumber: index + 1,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
