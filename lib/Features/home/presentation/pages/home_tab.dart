import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/Features/home/presentation/widgets/build_search_field.dart';
import 'package:online_exam_app/Features/home/presentation/widgets/subject_item.dart';
import 'package:online_exam_app/core/theme/app_colors.dart';
import 'package:online_exam_app/helper/spacing.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(
            horizontal: 20.0.w,
            vertical: 16.0.h,
          ),
          child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
          Text('Survey',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: AppColors.blue)),
                  verticalSpace(16),
            const BuildSearchField(),
            verticalSpace(40),
             Text('Browse by subject',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge),
                  verticalSpace(24),
                  Expanded(child: ListView.builder(
                    itemBuilder: (context, index) {
                      return const SubjectItem();
                      
                    }
                  ))
                ],
              ),
        ));
  }
}
