import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/routes/app_routes.dart';
import 'package:online_exam_app/core/theme/app_colors.dart';
import 'package:online_exam_app/helper/spacing.dart';

class SubjectItem extends StatelessWidget {
  const SubjectItem({super.key});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, AppRoutes.subjectDetails);
      },
      child: Container(
        margin: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 16.h),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child:   Row(
          children: [
            Image.asset('assets/images/Language .png'),
            horizontalSpace(20),
          Text('Language',style: Theme.of(context).textTheme.titleMedium,),
        ],),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow:  const [
             BoxShadow(
                offset: Offset(2, 2),
                        blurRadius: 12,
                        color: Color.fromRGBO(0, 0, 0, 0.16),
            ),
          ],
        ),
      ),
    );
  }
}
