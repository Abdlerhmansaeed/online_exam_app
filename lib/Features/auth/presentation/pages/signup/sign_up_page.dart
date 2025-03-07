import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app/Features/auth/presentation/manager/auth_cubit.dart';
import 'package:online_exam_app/Features/auth/presentation/manager/auth_states.dart';
import 'package:online_exam_app/core/Constant/app_constant.dart';
import 'package:online_exam_app/core/routes/app_routes.dart';
import 'package:online_exam_app/core/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/base_states/base_states.dart';
import '../../../../../core/di/di.dart';

class SignUpPage extends StatelessWidget {

  const SignUpPage({super.key,});
  @override

  Widget build(BuildContext context) {
    AuthCubit authCubit = getIt<AuthCubit>();

    return BlocProvider(
      create: (context) => authCubit,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: const Text('Sign Up'),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
              ),
            ),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state.signupStates is SuccessState) {
                  Navigator.pushReplacementNamed(
                      context, AppRoutes.layoutScreen);
                } else if (state.signupStates is ErrorState) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text((state.signupStates as ErrorState).error?? ""),
                      );
                    },
                  );
                } else if (state.signupStates is LoadingState) {
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
                          key: authCubit.signupFormKey,
                          child: Column(
                            children: [
                              TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "User Name is required";
                                  }
                                  return null;
                                },
                                controller: authCubit.userNameController,
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
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Required";
                                          }
                                          return null;
                                        },
                                        controller:
                                            authCubit.firstNameController,
                                        decoration: const InputDecoration(
                                            hintText: 'Enter First Name',
                                            labelText: 'First Name')),
                                  ),
                                  const Spacer(),
                                  SizedBox(
                                      width: 163.w,
                                      height: 56.h,
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Required";
                                          }
                                          return null;
                                        },
                                        controller:
                                            authCubit.lastNameController,
                                        decoration: const InputDecoration(
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
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Email is required";
                                    } else if (!AppConstant.emailRegex
                                        .hasMatch(value)) {
                                      return "Enter Valid Email";
                                    }
                                    return null;
                                  },
                                  controller: authCubit.emailController,
                                  decoration: const InputDecoration(
                                      hintText: 'Enter Email',
                                      labelText: 'Email')),
                              SizedBox(
                                height: 16.h,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 163.w,
                                    height: 56.h,
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Password Is Required";
                                        } else if(!AppConstant.passwordRegex
                                            .hasMatch(value)){
                                          return "Enter Strong Password";
                                        }
                                        return null;
                                      },
                                      controller: authCubit.passwordController,
                                      decoration: const InputDecoration(
                                          hintText: 'Enter Password',
                                          labelText: 'Password'),
                                    ),
                                  ),
                                  const Spacer(),
                                  SizedBox(
                                    width: 163.w,
                                    height: 56.h,
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Confirm Password is required";
                                        } else if (authCubit
                                                .passwordController.text !=
                                            authCubit
                                                .rePasswordController.text) {
                                          return "Not Matched";
                                        }
                                        return null;
                                      },
                                      controller:
                                          authCubit.rePasswordController,
                                      decoration: const InputDecoration(
                                          hintText: 'Confirm Password',
                                          labelText: 'Confirm Password'),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 16.h,
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Phone Is Required";
                                  } else if (!AppConstant.phoneRegex
                                      .hasMatch(value)) {
                                    return "Enter Valid Phone";
                                  }
                                  return null;
                                },
                                controller: authCubit.phoneNumberController,
                                decoration: const InputDecoration(
                                    hintText: 'Enter Phone Number',
                                    labelText: 'Phone Number'),
                              ),
                              SizedBox(
                                height: 16.h,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  if (authCubit.signupFormKey.currentState!
                                      .validate()) {
                                    authCubit.signup();
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0.r),
                                      child: const Text('Sign Up'),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Already have an account?'),
                                  TextButton(
                                    style: const ButtonStyle(
                                      overlayColor: WidgetStatePropertyAll(
                                          Colors.transparent),
                                    ),
                                    onPressed: () {
                                      Navigator.pushReplacementNamed(
                                          context, AppRoutes.loginPage);
                                    },
                                    child: const Text(
                                      'login',
                                      style: TextStyle(
                                        color: AppColors.blue,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ],
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
