import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/Features/user_results/presentation/widgets/answers_Card_widget.dart';

import '../../../../core/theme/app_colors.dart';

class AnswersView extends StatelessWidget {
  const AnswersView({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Answers"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: Column(
        children: [
         Expanded(child: ListView.builder(
           itemCount: 5,
           itemBuilder: (context, index) {
           return AnswersCardWidget();
         },))
        ],
      ),
    );
  }
}
