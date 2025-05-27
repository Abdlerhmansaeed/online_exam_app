import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/Features/auth/presentation/manager/auth_cubit.dart';
import 'package:online_exam_app/Features/auth/presentation/manager/auth_states.dart';
import 'package:online_exam_app/core/routes/app_routes.dart';
import 'package:online_exam_app/core/theme/app_colors.dart';
import 'package:online_exam_app/core/utils/app_validator.dart';
import 'package:online_exam_app/core/utils/extinstions.dart';

import '../../../../../core/di/di.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthCubit authCubit = getIt<AuthCubit>();

    return BlocProvider(
      create: (context) => authCubit,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sign Up'),
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
          leadingWidth: 20.w,
        ),
        body: BlocListener<AuthCubit, AuthStates>(
          listenWhen: (previous, current) =>
              previous.signupStates != current.signupStates,
          listener: (context, state) {
            state.signupStates?.when(
              initial: () {
                // No action for initial state
              },
              loading: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) =>
                      const Center(child: CircularProgressIndicator()),
                );
              },
              success: (data) {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.loginPage,
                  (route) => false,
                );
              },
              error: (error) {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
                context.showErrorDialog(
                  error ?? "An error occurred during signup",
                  context,
                );
              },
            );
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
            child: Form(
              key: authCubit.signupFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Username field
                  TextFormField(
                    validator: (value) => AppValidators.validateUserName(value),
                    controller: authCubit.userNameController,
                    onTapOutside: (_) =>
                        FocusManager.instance.primaryFocus?.unfocus(),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                        hintText: 'Enter Your User Name',
                        labelText: 'User Name'),
                  ),

                  SizedBox(height: 16.h),

                  // First Name and Last Name row
                  Row(
                    children: [
                      // First Name field
                      Expanded(
                        child: TextFormField(
                          validator: (value) =>
                              AppValidators.validateFirstName(value),
                          controller: authCubit.firstNameController,
                          onTapOutside: (_) =>
                              FocusManager.instance.primaryFocus?.unfocus(),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: const InputDecoration(
                              hintText: 'Enter First Name',
                              labelText: 'First Name'),
                        ),
                      ),

                      SizedBox(width: 16.w),

                      // Last Name field
                      Expanded(
                        child: TextFormField(
                          validator: (value) =>
                              AppValidators.validateLastName(value),
                          controller: authCubit.lastNameController,
                          onTapOutside: (_) =>
                              FocusManager.instance.primaryFocus?.unfocus(),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: const InputDecoration(
                            hintText: 'Enter Last Name',
                            labelText: 'Last Name',
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16.h),

                  // Email field
                  TextFormField(
                    validator: (value) => AppValidators.validateEmail(value),
                    controller: authCubit.emailController,
                    onTapOutside: (_) =>
                        FocusManager.instance.primaryFocus?.unfocus(),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                        hintText: 'Enter Email', labelText: 'Email'),
                  ),

                  SizedBox(height: 16.h),

                  // Password and Confirm Password row
                  Row(
                    children: [
                      // Password field
                      Expanded(
                        child: TextFormField(
                          validator: (value) =>
                              AppValidators.validatePassword(value),
                          controller: authCubit.passwordController,
                          onTapOutside: (_) =>
                              FocusManager.instance.primaryFocus?.unfocus(),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          obscureText: true,
                          obscuringCharacter: "*",
                          decoration: const InputDecoration(
                              hintText: 'Enter Password',
                              labelText: 'Password'),
                        ),
                      ),

                      SizedBox(width: 16.w),

                      // Confirm Password field
                      Expanded(
                        child: TextFormField(
                          validator: (value) =>
                              AppValidators.validateConfirmPassword(
                                  value, authCubit.passwordController.text),
                          controller: authCubit.rePasswordController,
                          onTapOutside: (_) =>
                              FocusManager.instance.primaryFocus?.unfocus(),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          obscureText: true,
                          obscuringCharacter: "*",
                          decoration: const InputDecoration(
                              hintText: 'Confirm Password',
                              labelText: 'Confirm Password'),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16.h),

                  // Phone field
                  TextFormField(
                    validator: (value) =>
                        AppValidators.validatePhoneNumber(value),
                    controller: authCubit.phoneNumberController,
                    onTapOutside: (_) =>
                        FocusManager.instance.primaryFocus?.unfocus(),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                        hintText: 'Enter Phone Number',
                        labelText: 'Phone Number'),
                  ),

                  SizedBox(height: 24.h),

                  // Sign Up button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blue,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                    ),
                    onPressed: () {
                      if (authCubit.signupFormKey.currentState!.validate()) {
                        authCubit.signup();
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // Login redirect row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(fontSize: 14.sp),
                      ),
                      TextButton(
                        style: const ButtonStyle(
                          overlayColor:
                              WidgetStatePropertyAll(Colors.transparent),
                        ),
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, AppRoutes.loginPage);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Login',
                              style: TextStyle(
                                color: AppColors.blue,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
