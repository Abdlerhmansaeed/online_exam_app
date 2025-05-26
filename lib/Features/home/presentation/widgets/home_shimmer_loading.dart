import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/helper/spacing.dart';

class HomeShimmerLoading extends StatelessWidget {
  const HomeShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header Shimmer (Survey title)
        _buildHeaderShimmer(),

        // Search Field Shimmer
        _buildSearchFieldShimmer(),

        // Section Header Shimmer (Browse by subject)
        _buildSectionHeaderShimmer(),

        // List Items Shimmer
        Expanded(
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(bottom: 20.h),
            itemCount: 6,
            itemBuilder: (context, index) => _buildSubjectItemShimmer(index),
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderShimmer() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 16.0.h),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          width: 70.w,
          height: 24.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchFieldShimmer() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          width: double.infinity,
          height: 48.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(color: Colors.grey[200]!),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeaderShimmer() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 24.0.h),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          width: 150.w,
          height: 24.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
      ),
    );
  }

  Widget _buildSubjectItemShimmer(int index) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20.0.w,
        right: 20.0.w,
        bottom: 12.0.h,
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: [
              // Subject icon placeholder (square with rounded corners)
              Container(
                width:
                    50.r, // Square dimensions to match your subject icon layout
                height: 50.r,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              horizontalSpace(16.w),
              // Subject name placeholder
              Expanded(
                child: Container(
                  height: 20.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
