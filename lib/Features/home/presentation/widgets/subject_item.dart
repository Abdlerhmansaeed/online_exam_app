import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/Features/home/domain/entity/exams_on_subject_entity.dart';
import 'package:online_exam_app/core/routes/app_routes.dart';
import 'package:online_exam_app/core/theme/app_colors.dart';
import '../../../../core/helper/spacing.dart';

class SubjectItem extends StatelessWidget {
  final String imageUrl;
  final String name;
  SubjectItem({Key? key, required this.imageUrl, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 16.h),
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Row(
        children: [
          CachedNetworkImage(
            width: 60.w,
            height: 60.h,
            imageUrl: imageUrl,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          horizontalSpace(20),
          Text(
            name,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: const [
          BoxShadow(
            offset: Offset(2, 2),
            blurRadius: 12,
            color: Color.fromRGBO(0, 0, 0, 0.16),
          ),
        ],
      ),
    );
  }
}
