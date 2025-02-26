import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/Features/auth/presentation/manager/auth_states.dart';
import '../../../../../core/Constant/app_constant.dart';
import '../../../../../core/di/di.dart';
import '../../../../../core/routes/app_routes.dart';
import '../../manager/auth_cubit.dart';

class ResetPasswordPage extends StatelessWidget {

  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    AuthCubit authCubit = getIt<AuthCubit>();

    return BlocProvider(
      create: (context) => authCubit,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: const Text('Reset Password'),
              leading: IconButton(
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
              ),
            ),
            BlocListener<AuthCubit, AuthStates>(
              listener: (context, state) {
                if (state is ResetPasswordSuccessState) {
                  Navigator.pushReplacementNamed(context, AppRoutes.homePage);
                } else if (state is ResetPasswordErrorState) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(state.error),
                      );
                    },
                  );
                } else if (state is ResetPasswordLoadingState) {
                  // Show loading dialog
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) =>
                        const Center(child: CircularProgressIndicator()),
                  );
                }
              },
              child: BlocBuilder<AuthCubit, AuthStates>(
                builder: (context, state) {
                  return SliverPadding(
                    padding: const EdgeInsets.all(16),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate.fixed(
                        [
                          Column(
                            children: [
                              Text(
                                'Reset Password',
                                style: theme.textTheme.titleLarge,
                              ),
                              SizedBox(height: 16.h),
                              const Text(
                                "Password must not be empty and must contain\n 6 characters with upper case letter and one\n number at least ",
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          SizedBox(height: 32.h),
                          TextFormField(
                            controller:
                            context.read<AuthCubit>().emailController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Email is required";
                              } else if (!AppConstant.emailRegex
                                  .hasMatch(value)) {
                                return "Enter Valid Email";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              label: Text('Email'),
                              hintText: 'Enter your email',
                            ),
                          ),
                          SizedBox(height: 24.h),
                          TextFormField(
                            controller:
                                context.read<AuthCubit>().passwordController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "please enter your password";
                              } else if (!AppConstant.passwordRegex
                                  .hasMatch(value)) {
                                return "Please add a Strong Password";
                              }
                              return null;
                            },
                            obscureText: true,
                            obscuringCharacter: "*",
                            decoration: const InputDecoration(
                              label: Text('New Password'),
                              hintText: 'Enter Your New Password',
                            ),
                          ),
                          SizedBox(height: 48.h),
                          ElevatedButton(
                            onPressed: () {
                              context.read<AuthCubit>().resetPassword();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0.r),
                                  child: const Text('Continue'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
