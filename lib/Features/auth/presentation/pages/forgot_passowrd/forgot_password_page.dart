import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/Features/auth/presentation/manager/auth_cubit.dart';
import 'package:online_exam_app/Features/auth/presentation/manager/auth_states.dart';
import 'package:online_exam_app/core/routes/app_routes.dart';
import 'package:online_exam_app/core/theme/app_colors.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key, required this.authCubit});
  AuthCubit authCubit;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocProvider.value(
      value: authCubit,
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
            BlocConsumer<AuthCubit, AuthStates>(
              listener: (context, state) {
                if (state is! ForgetPasswordLoadingState) {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                }

                if (state is ForgetPasswordSuccessState) {
                  Navigator.pushReplacementNamed(context, AppRoutes.otpPage,
                      arguments: authCubit);
                } else if (state is ForgetPasswordLoadingState) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return const Center(child: CircularProgressIndicator());
                    },
                  );
                } else if (state is ForgetPasswordErrorState) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Error"),
                        content: Text(state.error),
                      );
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
                                  } else if (!RegExp(
                                          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+"
                                          r"@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                          r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                          r"{0,253}[a-zA-Z0-9])?)*$")
                                      .hasMatch(value)) {
                                    return "Enter Valid Email";
                                  } else if (state
                                      is ForgetPasswordErrorState) {
                                    return state.error;
                                  }
                                  return null;
                                },
                                controller:
                                    authCubit.forgetPasswordEmailController,
                                decoration: InputDecoration(
                                  hintText: 'Enter Your Email',
                                  labelText: 'Email',
                                  errorText: state is ForgetPasswordErrorState
                                      ? state.error
                                      : null,
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
