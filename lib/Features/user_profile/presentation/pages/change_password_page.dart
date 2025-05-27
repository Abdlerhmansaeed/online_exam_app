import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:online_exam_app/Features/user_profile/presentation/manager/profile_view_model_cubit.dart';
import 'package:online_exam_app/Features/user_profile/presentation/manager/profile_view_model_state.dart';
import 'package:online_exam_app/core/app_manger/app_manger.dart';
import 'package:online_exam_app/core/utils/app_validator.dart';
import 'package:online_exam_app/core/theme/app_colors.dart';

class ChangePasswordPage extends StatefulWidget {
  final ProfileViewModelCubit profileCubit;
  const ChangePasswordPage({super.key, required this.profileCubit});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.profileCubit,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: const Text('Reset Password'),
              leadingWidth: 20,
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back_ios_new_rounded),
              ),
            ),
            BlocConsumer<ProfileViewModelCubit, ProfileStates>(
              listener: (context, state) {
                state.changePassword?.when(
                  initial: () {},
                  loading: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) =>
                          const Center(child: CircularProgressIndicator()),
                    );
                  },
                  success: (data) {
                    Navigator.pop(context); // Close loading dialog

                    // Show success animation dialog
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          backgroundColor: AppColors.white.withOpacity(0.7),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Password changed successfully",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.black,
                                ),
                              ),
                              SizedBox(height: 16.h),
                              Lottie.asset(
                                'assets/images/Success_animation.json',
                                repeat: false,
                                width: 150.w,
                                height: 150.h,
                                fit: BoxFit.cover,
                                onLoaded: (p0) {
                                  Future.delayed(
                                    const Duration(seconds: 2),
                                    () {
                                      if (context.mounted) {
                                        Navigator.pop(context); // Close dialog
                                        Navigator.pop(
                                            context); // Go back to profile
                                        context
                                            .read<AppManger>()
                                            .changeBottomNavBar(0);
                                      }
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  error: (error) {
                    Navigator.pop(context); // Close loading dialog

                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: AppColors.white.withOpacity(0.7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text("Error"),
                              Icon(
                                Icons.error,
                                color: Colors.red,
                                size: 50.w,
                              ),
                              Text(
                                error ?? 'An unexpected error occurred.',
                              ),
                              SizedBox(height: 16.h),
                              ElevatedButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(4),
                                      child: Text('OK'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              },
              builder: (context, state) {
                return SliverPadding(
                  padding:
                      EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate.fixed([
                      Form(
                        key: widget.profileCubit.changePasswordFormKey,
                        child: Column(
                          children: [
                            SizedBox(height: 24.h),

                            // Current Password Field
                            TextFormField(
                              controller:
                                  widget.profileCubit.passwordController,
                              obscureText: _obscureCurrentPassword,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Current password is required';
                                }
                                return null;
                              },
                              onTapOutside: (event) =>
                                  FocusScope.of(context).unfocus(),
                              decoration: InputDecoration(
                                hintText: 'Current Password',
                                labelText: 'Current Password',
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureCurrentPassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: AppColors.blue,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscureCurrentPassword =
                                          !_obscureCurrentPassword;
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 16.h),

                            // New Password Field
                            TextFormField(
                              controller:
                                  widget.profileCubit.newPasswordController,
                              obscureText: _obscureNewPassword,
                              validator: (value) =>
                                  AppValidators.validatePassword(value),
                              onTapOutside: (event) =>
                                  FocusScope.of(context).unfocus(),
                              decoration: InputDecoration(
                                hintText: 'New Password',
                                labelText: 'New Password',
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureNewPassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: AppColors.blue,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscureNewPassword =
                                          !_obscureNewPassword;
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 16.h),

                            // Confirm Password Field
                            TextFormField(
                              controller:
                                  widget.profileCubit.confirmPasswordController,
                              obscureText: _obscureConfirmPassword,
                              validator: (value) =>
                                  AppValidators.validateConfirmPassword(
                                value,
                                widget.profileCubit.newPasswordController.text,
                              ),
                              onTapOutside: (event) =>
                                  FocusScope.of(context).unfocus(),
                              decoration: InputDecoration(
                                hintText: 'Confirm Password',
                                labelText: 'Confirm Password',
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureConfirmPassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: AppColors.blue,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscureConfirmPassword =
                                          !_obscureConfirmPassword;
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 40.h),

                            // Update Button
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                elevation: 0,
                              ),
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                if (widget.profileCubit.changePasswordFormKey
                                    .currentState!
                                    .validate()) {
                                  widget.profileCubit.changePassword();
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0.r),
                                    child: Text(
                                      'Update Password',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20.h),
                          ],
                        ),
                      ),
                    ]),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
