import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/Features/profile/presentation/manager/profile_cubit.dart';
import 'package:online_exam_app/Features/profile/presentation/manager/profile_states.dart';
import 'package:online_exam_app/core/Constant/app_constant.dart';
import 'package:online_exam_app/core/base_states/base_states.dart';
import 'package:online_exam_app/core/di/di.dart';
import 'package:online_exam_app/core/routes/app_routes.dart';

import '../../../../core/theme/app_colors.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileCubit profileCubit = getIt<ProfileCubit>();

    return BlocProvider(
      create: (context) => profileCubit,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: const Text('Reset Password'),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
              ),
            ),
            BlocConsumer<ProfileCubit,ProfileStates>(
              listener: (context, state) {
                if (state.getUserProfileStates is SuccessState) {
                  Navigator.pushReplacementNamed(
                      context, AppRoutes.layoutScreen);
                } else if (state.getUserProfileStates is ErrorState) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text((state.getUserProfileStates as ErrorState).error?? ""),
                      );
                    },
                  );
                } else if (state.getUserProfileStates is LoadingState) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) =>
                    const Center(child: CircularProgressIndicator()),
                  );
                }
              },
              builder: (context, state) {
                return SliverPadding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate.fixed(
                      [
                        Form(
                          key: profileCubit.profileFormKey,
                          child: Column(
                            children: [
                              TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Password Is Required";
                                  } else if(!AppConstant.passwordRegex
                                      .hasMatch(value)){
                                    return "Enter your Password";
                                  }
                                  return null;
                                },
                                controller: profileCubit.passwordController,
                                decoration: const InputDecoration(
                                    hintText: 'Current Password',
                                    labelText: 'Current Password'),
                              ),
                              SizedBox(
                                height: 16.h,
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Password Is Required";
                                  } else if(!AppConstant.passwordRegex
                                      .hasMatch(value)){
                                    return "Enter Strong Password";
                                  }
                                  return null;
                                },
                                controller: profileCubit.newPasswordController,
                                decoration: const InputDecoration(
                                    hintText: 'New Password',
                                    labelText: 'New Password'),
                              ),
                              SizedBox(
                                height: 16.h,
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Password Is Required";
                                  } else if(!AppConstant.passwordRegex
                                      .hasMatch(value)){
                                    return "Enter Strong Password";
                                  }
                                  return null;
                                },
                                controller: profileCubit.confirmPasswordController,
                                decoration: const InputDecoration(
                                    hintText: 'Confirm Password',
                                    labelText: 'Confirm Password'),
                              ),
                              SizedBox(
                                height: 40.h,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  if (profileCubit.profileFormKey.currentState!
                                      .validate()) {
                                    profileCubit.changePassword();
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
            ),
          ],
        ),
      ),
    );
  }
}
