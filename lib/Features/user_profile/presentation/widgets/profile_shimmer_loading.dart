import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/helper/spacing.dart';

class ProfileShimmerLoading extends StatelessWidget {
  const ProfileShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[200]!,
      highlightColor: Colors.grey[150]!,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Avatar Shimmer
            _buildAvatarShimmer(),
            
            verticalSpace(32),
            
            // Form Fields Shimmer
            _buildFormFieldShimmer('User Name'),
            verticalSpace(16),
            
            _buildFormFieldShimmer('First Name'),
            verticalSpace(16),
            
            _buildFormFieldShimmer('Last Name'),
            verticalSpace(16),
            
            _buildFormFieldShimmer('Email'),
            verticalSpace(16),
            
            _buildFormFieldShimmer('Phone Number'),
            verticalSpace(32),
            
            // Update Button Shimmer
            _buildButtonShimmer(),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatarShimmer() {
    return Column(
      children: [
        // Profile Image Circle
        Container(
          width: 120.w,
          height: 120.w,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
        verticalSpace(12),
        
        // "Change Photo" text shimmer
        Container(
          width: 100.w,
          height: 16.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
      ],
    );
  }

  Widget _buildFormFieldShimmer(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label shimmer
        Container(
          width: 80.w,
          height: 14.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
        verticalSpace(8),
        
        // Text field shimmer
        Container(
          width: double.infinity,
          height: 56.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: Colors.grey[200]!),
          ),
        ),
      ],
    );
  }

  Widget _buildButtonShimmer() {
    return Container(
      width: double.infinity,
      height: 48.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
    );
  }
}