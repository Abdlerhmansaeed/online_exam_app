import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/Features/user_results/presentation/widgets/cart_widget.dart';
import 'package:online_exam_app/core/theme/app_colors.dart';

import '../../../../core/helper/spacing.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Result",
                style: theme.textTheme.titleMedium!.copyWith(fontSize: 20.sp),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context, index) {
                  return CartWidget();
                },),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
