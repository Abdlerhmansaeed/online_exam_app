import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:online_exam_app/Features/user_profile/presentation/manager/profile_view_model_cubit.dart';
import 'package:online_exam_app/Features/user_profile/presentation/widgets/profile_sliver_shimmer.dart';
import 'package:online_exam_app/core/app_manger/app_manger.dart';
import 'package:online_exam_app/core/utils/app_validator.dart';
import '../../../../core/theme/app_colors.dart';
import '../manager/profile_view_model_state.dart';
import 'change_password_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    var profileCubit = context.read<ProfileViewModelCubit>();
    return PopScope(
      onPopInvoked: (didPop) {
        if (didPop) {
          context.read<AppManger>().changeBottomNavBar(0);
        }
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
                title: const Text('Profile'),
                leadingWidth: 20,
                leading: GestureDetector(
                    onTap: () {
                      context.read<AppManger>().changeBottomNavBar(0);
                    },
                    child: const Icon(Icons.arrow_back_ios_new_rounded))),
            BlocConsumer<ProfileViewModelCubit, ProfileStates>(
              listener: (context, state) {
                state.editProfile?.when(
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
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          backgroundColor: AppColors.white.withOpacity(
                            0.7,
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Profile updated successfully",
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
                                        Navigator.pop(context);
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
                  error: (error) => {
                    Navigator.pop(context),
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: AppColors.white.withOpacity(0.7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          // title: Co(child: const Text('Error')),
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
                    )
                  },
                );
              },
              builder: (context, state) {
                return state.getUserProfileStates?.when(
                      error: (error) {
                        return SliverFillRemaining(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.error_outline_rounded,
                                  color: Colors.red,
                                  size: 50.w,
                                ),
                                SizedBox(height: 16.h),
                                Text(
                                  error ?? 'An unexpected error occurred.',
                                  style: TextStyle(
                                      fontSize: 16.sp, color: Colors.red),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 16.h),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.blue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    elevation: 0,
                                    maximumSize: Size(150.w, 50.h),
                                  ),
                                  onPressed: () {
                                    profileCubit.getUserProfile();
                                  },
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text('Retry'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      initial: () {
                        return const ProfileSliverShimmer();
                      },
                      loading: () {
                        return const ProfileSliverShimmer();
                      },
                      success: (data) {
                        return SliverPadding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          sliver: SliverList(
                            delegate: SliverChildListDelegate.fixed(
                              [
                                Form(
                                  key: profileCubit.profileFormKey,
                                  child: Column(
                                    children: [
                                      Stack(
                                        children: [
                                          CircleAvatar(
                                            radius: 50.r,
                                            backgroundColor: AppColors.blue,
                                            child: Icon(
                                              Icons.person,
                                              size: 100.w,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            right: 0,
                                            child: CircleAvatar(
                                              radius: 15.r,
                                              backgroundColor: AppColors.white,
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.camera_alt,
                                                  size: 15.w,
                                                  color: AppColors.blue,
                                                ),
                                                onPressed: () {},
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 40.h,
                                      ),
                                      TextFormField(
                                        controller:
                                            profileCubit.userNameController,
                                        onTapOutside: (event) =>
                                            FocusScope.of(context).unfocus(),
                                        decoration: const InputDecoration(
                                            hintText: 'Enter Your User Name',
                                            labelText: 'User Name'),
                                      ),
                                      SizedBox(
                                        height: 16.h,
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 163.w,
                                            height: 56.h,
                                            child: TextFormField(
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              onTapOutside: (event) =>
                                                  FocusScope.of(context)
                                                      .unfocus(),
                                              validator: (value) =>
                                                  AppValidators
                                                      .validateUserName(value),
                                              controller: profileCubit
                                                  .firstNameController,
                                              decoration: const InputDecoration(
                                                  hintText: 'Enter First Name',
                                                  labelText: 'First Name'),
                                            ),
                                          ),
                                          const Spacer(),
                                          SizedBox(
                                              width: 163.w,
                                              height: 56.h,
                                              child: TextFormField(
                                                autovalidateMode:
                                                    AutovalidateMode
                                                        .onUserInteraction,
                                                onTapOutside: (event) =>
                                                    FocusScope.of(context)
                                                        .unfocus(),
                                                validator: (value) =>
                                                    AppValidators
                                                        .validateUserName(
                                                            value),
                                                controller: profileCubit
                                                    .lastNameController,
                                                decoration:
                                                    const InputDecoration(
                                                  hintText: 'Enter Last Name',
                                                  labelText: 'Last Name',
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 16.h,
                                      ),
                                      TextFormField(
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          onTapOutside: (event) =>
                                              FocusScope.of(context).unfocus(),
                                          validator: (value) =>
                                              AppValidators.validateEmail(
                                                  value),
                                          controller:
                                              profileCubit.emailController,
                                          decoration: const InputDecoration(
                                              hintText: 'Enter Email',
                                              labelText: 'Email')),
                                      SizedBox(
                                        height: 16.h,
                                      ),
                                      SizedBox(
                                        child: Stack(
                                          children: [
                                            TextFormField(
                                              readOnly: true,
                                              controller: profileCubit
                                                  .passwordController,
                                              onTapOutside: (event) =>
                                                  FocusScope.of(context)
                                                      .unfocus(),
                                              decoration: InputDecoration(
                                                prefixIcon: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 12.w),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        '********',
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 25.sp,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              right: 0,
                                              child: TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .push(MaterialPageRoute(
                                                      builder: (context) {
                                                        return const ChangePasswordPage();
                                                      },
                                                    ));
                                                  },
                                                  child: const Text("change")),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 16.h,
                                      ),
                                      TextFormField(
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        onTapOutside: (event) =>
                                            FocusScope.of(context).unfocus(),
                                        validator: (value) =>
                                            AppValidators.validatePhoneNumber(
                                                value),
                                        controller:
                                            profileCubit.phoneNumberController,
                                        decoration: const InputDecoration(
                                            hintText: 'Enter Phone Number',
                                            labelText: 'Phone Number'),
                                      ),
                                      SizedBox(
                                        height: 16.h,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          if (profileCubit
                                              .profileFormKey.currentState!
                                              .validate()) {
                                            profileCubit.editProfile();
                                          }
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(8.0.r),
                                              child: const Text('Update'),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ) ??
                    const SliverFillRemaining(
                      child: ProfileSliverShimmer(),
                    );
              },
            ),
          ],
        ),
      ),
    );
  }
}
