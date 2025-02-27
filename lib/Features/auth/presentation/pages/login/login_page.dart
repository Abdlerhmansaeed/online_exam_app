import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app/Features/auth/presentation/manager/auth_cubit.dart';
import 'package:online_exam_app/Features/auth/presentation/manager/auth_states.dart';
import 'package:online_exam_app/core/routes/app_routes.dart';
import 'package:online_exam_app/core/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/Constant/app_constant.dart';
import '../../../../../core/di/di.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    AuthCubit authCubit = getIt<AuthCubit>();
    return BlocProvider(
      create: (context) => authCubit,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            const SliverAppBar(
              title: Text('Login'),
              leading: Icon(Icons.arrow_back_ios_new_rounded),
            ),
            BlocConsumer<AuthCubit, AuthStates>(
              listener: (context, state) {
                if (state is! LoginLoadingState) {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                }

                if (state is LoginSuccessState) {
                  Navigator.pushReplacementNamed(
                      context, AppRoutes.homeScreen);
                } else if (state is LoginErrorState) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(state.error),
                      );
                    },
                  );
                } else if (state is LoginLoadingState) {
                  showDialog(
                    context: context,
                    barrierDismissible: false, // Prevent closing while loading
                    builder: (_) =>
                        const Center(child: CircularProgressIndicator()),
                  );
                }
              },
              builder: (context, state) {
                return SliverPadding(
                  padding:
                      EdgeInsets.symmetric(vertical: 8.w, horizontal: 16.h),
                  sliver: SliverList(
                      delegate: SliverChildListDelegate.fixed([
                    Form(
                      key: authCubit.loginFormKey,
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Email Can not be empty";
                              } else if (!AppConstant.emailRegex
                                  .hasMatch(value)) {
                                return "Enter Valid Email";
                              } else if (state is LoginErrorState) {
                                return state.error;
                              }
                              return null;
                            },
                            controller: authCubit.emailController,
                            decoration: const InputDecoration(
                              hintText: 'Enter Your Email',
                              labelText: ' Email',
                            ),
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "please enter your password";
                              } else if (!AppConstant.passwordRegex
                                  .hasMatch(value)) {
                                return "Please Enter your correct password";
                              }
                              return null;
                            },
                            obscureText: true,
                            obscuringCharacter: "*",
                            controller: authCubit.passwordController,
                            decoration: const InputDecoration(
                              hintText: 'Enter Your Password',
                              labelText: 'Password',
                            ),
                          ),
                          Row(
                            children: [
                              ValueListenableBuilder(
                                valueListenable: authCubit.checkBoxValue,
                                builder: (context, value, child) {
                                  return Checkbox(
                                    value: value,
                                    side: const BorderSide(color: AppColors.gray),
                                    overlayColor: const WidgetStatePropertyAll(Colors.transparent),
                                    onChanged: (newValue) {
                                      if (newValue != null) {
                                        authCubit.rememberMe(newValue);
                                      }
                                    },
                                  );
                                },
                              ),
                              const Text('Remember me'),
                              const Spacer(),
                              TextButton(
                                style: const ButtonStyle(
                                  overlayColor: WidgetStatePropertyAll(
                                      Colors.transparent),
                                ),
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    AppRoutes.forgotPass,
                                  );
                                },
                                child: const Text(
                                  'Forgot password?',
                                  style: TextStyle(
                                    color: AppColors.blue,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 48.h,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (authCubit.loginFormKey.currentState!
                                  .validate()) {
                                authCubit.login();
                              }
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text("Login"),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Don\'t have an account?'),
                              TextButton(
                                style: const ButtonStyle(
                                  overlayColor: WidgetStatePropertyAll(
                                      Colors.transparent),
                                ),
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, AppRoutes.signUpPage,
                                      arguments: authCubit);
                                },
                                child: const Text(
                                  'Sign up',
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
                    ),
                  ])),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
