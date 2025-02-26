import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_exam_app/core/theme/app_colors.dart';

class BuildSearchField extends StatelessWidget {
  const BuildSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoSearchTextField(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.black),
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
