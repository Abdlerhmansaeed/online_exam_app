import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/Features/auth/presentation/manager/auth_cubit.dart';
import 'package:online_exam_app/Features/auth/presentation/manager/auth_states.dart';
import 'package:online_exam_app/core/Constant/app_constant.dart';
import 'package:online_exam_app/core/routes/app_routes.dart';
import '../../../../../core/base_states/base_states.dart';
import '../../../../../core/di/di.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});
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
              title: const Text('Forgot Password'),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
              ),
            ),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state.forgetPasswordStates is! LoadingState) {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                }

                if (state.forgetPasswordStates is SuccessState) {
                  Navigator.pushReplacementNamed(context, AppRoutes.otpPage,
                      arguments: authCubit);
                } else if (state.forgetPasswordStates is LoadingState) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return const Center(child: CircularProgressIndicator());
                    },
                  );
                } else if (state.forgetPasswordStates is ErrorState) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Error"),
                        content: Text((state.forgetPasswordStates as ErrorState).error?? ""));
                    },
                  );
                }
              },
              builder: (context, state) {
                return SliverPadding(
                  padding: EdgeInsets.all(16.r),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate.fixed(
                      [
                        Form(
                          key: authCubit.forgotPasswordFormKey,
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "Email verification",
                                    style: theme.textTheme.titleLarge,
                                  ),
                                  SizedBox(height: 16.h),
                                  const Text(
                                    "Please enter your code that send to your\n email address ",
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              SizedBox(height: 16.h),
                              TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Email Can not be empty";
                                  } else if (!AppConstant.emailRegex
                                      .hasMatch(value)) {
                                    return "Enter Valid Email";
                                  }
                                  return null;
                                },

                                controller:
                                    authCubit.forgetPasswordEmailController,
                                decoration: InputDecoration(
                                  hintText: 'Enter Your Email',
                                  labelText: 'Email',

                                ),
                              ),
                              SizedBox(
                                height: 48.h,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  if (authCubit
                                      .forgotPasswordFormKey.currentState!
                                      .validate()) {
                                    authCubit.forgetPasswordEmailVerify();
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0.r),
                                      child: const Text(
                                        "Continue",
                                      ),
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
