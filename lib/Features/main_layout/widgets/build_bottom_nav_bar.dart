// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/theme/app_colors.dart';

class BuildBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final void Function(int)? onTabFunction;
  final BuildContext context;

  const BuildBottomNavBar({
    super.key,
    required this.context,
    required this.selectedIndex,
    required this.onTabFunction,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.white.withValues(
        alpha: 240,
        red: 255,
        green: 255,
        blue: 255,
      ),
      selectedItemColor: AppColors.blue,
      onTap: onTabFunction,
      currentIndex: selectedIndex,
      items: [
        BottomNavigationBarItem(
          icon: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
              decoration: BoxDecoration(
                color: selectedIndex == 0
                    ? const Color(0xffCCD7EB)
                    : Colors.transparent,
                borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(20.r), right: Radius.circular(20.r)),
              ),
              child: const ImageIcon(
                AssetImage('assets/images/home_Icon.png'),
              )),
          label: 'Explore',
        ),
        BottomNavigationBarItem(
          icon: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
              decoration: BoxDecoration(
                  color: selectedIndex == 1
                      ? const Color(0xffCCD7EB)
                      : Colors.transparent,
                  borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(20.r),
                      right: Radius.circular(20.r))),
              child: const ImageIcon(
                AssetImage('assets/images/result_icon.png'),
              )),
          label: 'Result',
        ),
        BottomNavigationBarItem(
          icon: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
              decoration: BoxDecoration(
                  color: selectedIndex == 2
                      ? const Color(0xffCCD7EB)
                      : Colors.transparent,
                  borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(20.r),
                      right: Radius.circular(20.r))),
              child: const Icon(Icons.person)),
          label: 'Profile',
        ),
      ],
    );
  }
}
