import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/helper/spacing.dart';

class HomeSliverShimmer extends StatelessWidget {
  const HomeSliverShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        // Header Shimmer (Survey title)
        _buildHeaderShimmer(),

        // Search Field Shimmer
        _buildSearchFieldShimmer(),

        // Section Header Shimmer (Browse by subject)
        _buildSectionHeaderShimmer(),

        // Subject Items (6 of them to fill the screen)
        ...List.generate(6, (index) => _buildSubjectItemShimmer(index)),

        // Bottom spacing
        SizedBox(height: 20.h),
      ]),
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
            borderRadius: BorderRadius.circular(30.r), // جعله أكثر استدارة
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Row(
            // أضف أيقونة البحث والنص الوهمي
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16.w),
                child: Container(
                  width: 20.w,
                  height: 20.h,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Container(
                width: 100.w,
                height: 16.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ],
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
          height: 80.h, // ضبط الارتفاع ليطابق الـ UI الحقيقي
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              // أيقونة المادة
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Container(
                  width: 48.r,
                  height: 48.r,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 16.w),
              // اسم المادة
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
