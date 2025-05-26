import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app/Features/auth/presentation/manager/auth_cubit.dart';
import 'package:online_exam_app/Features/auth/presentation/manager/auth_states.dart';
import 'package:online_exam_app/core/routes/app_routes.dart';
import 'package:online_exam_app/core/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/Constant/app_regx.dart';
import '../../../../../core/base_states/base_states.dart';
import '../../../../../core/di/di.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => getIt<AuthCubit>(),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            const SliverAppBar(
              title: Text('Login'),
              leading: Icon(Icons.arrow_back_ios_new_rounded),
            ),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                state.loginStates.whenOrNull(
                  success: (_) {
                    Navigator.pushReplacementNamed(context, AppRoutes.layoutScreen);
                  },
                  error: (message) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(message ?? "An error occurred"),
                        );
                      },
                    );
                  },
                  loading: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) => const Center(child: CircularProgressIndicator()),
                    );
                  },
                );
              },
              builder: (context, state) {
                return SliverPadding(
                  padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 16.h),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate.fixed([
                      Form(
                        key: context.read<AuthCubit>().loginFormKey,
                        child: Column(
                          children: [
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Email cannot be empty";
                                } else if (!AppRegx.emailRegex.hasMatch(value)) {
                                  return "Enter a valid email";
                                }
                                return null;
                              },
                              onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              controller: context.read<AuthCubit>().emailController,
                              decoration: const InputDecoration(
                                hintText: 'Enter Your Email',
                                labelText: 'Email',
                              ),
                            ),
                            SizedBox(height: 16.h),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter your password";
                                } else if (!AppRegx.passwordRegex.hasMatch(value)) {
                                  return "Please enter a valid password";
                                }
                                return null;
                              },
                              onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              obscureText: true,
                              obscuringCharacter: "*",
                              controller: context.read<AuthCubit>().passwordController,
                              decoration: const InputDecoration(
                                hintText: 'Enter Your Password',
                                labelText: 'Password',
                              ),
                            ),
                            Row(
                              children: [
                                ValueListenableBuilder(
                                  valueListenable: context.read<AuthCubit>().checkBoxValue,
                                  builder: (context, value, child) {
                                    return Checkbox(
                                      value: value,
                                      side: const BorderSide(color: AppColors.gray),
                                      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
                                      onChanged: (newValue) {
                                        if (newValue != null) {
                                          context.read<AuthCubit>().rememberMe(newValue);
                                        }
                                      },
                                    );
                                  },
                                ),
                                const Text('Remember me'),
                                const Spacer(),
                                TextButton(
                                  style: const ButtonStyle(
                                    overlayColor: WidgetStatePropertyAll(Colors.transparent),
                                  ),
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(context, AppRoutes.forgotPass);
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
                            SizedBox(height: 48.h),
                            ElevatedButton(
                              onPressed: () {
                                if (context.read<AuthCubit>().loginFormKey.currentState!.validate()) {
                                  context.read<AuthCubit>().login();
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
                                const Text("Don't have an account?"),
                                TextButton(
                                  style: const ButtonStyle(
                                    overlayColor: WidgetStatePropertyAll(Colors.transparent),
                                  ),
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                      context,
                                      AppRoutes.signUpPage,
                                      arguments: context.read<AuthCubit>(),
                                    );
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
