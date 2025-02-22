import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/Features/home/presentation/widgets/subject_item.dart';
import 'package:online_exam_app/helper/spacing.dart';

class SubjectDetail extends StatelessWidget {
  const SubjectDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: ()=> Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios_new_rounded),),
        title: const Text('Language'),),
        body: Padding(
          padding:  EdgeInsets.symmetric(
            horizontal: 20.0.w,
            vertical: 16.0.h,
          ),
          child: Column(
            children: [
              verticalSpace(40),
              Text('English',style: Theme.of(context).textTheme.titleLarge,),
               verticalSpace(20),
               Expanded(child: ListView.builder(
                 itemBuilder: (context, index) {
                   return const SubjectItem();
                 }
               ))
            ],
          ),
        ),
    );
  }
}