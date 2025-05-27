import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/Features/auth/presentation/manager/auth_cubit.dart';
import 'package:online_exam_app/Features/auth/presentation/manager/auth_states.dart';
import 'package:online_exam_app/core/routes/app_routes.dart';
import 'package:online_exam_app/core/utils/app_validator.dart';
import 'package:online_exam_app/core/utils/extinstions.dart';
import '../../../../../core/di/di.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    AuthCubit authCubit = getIt<AuthCubit>();

    return BlocProvider(
      create: (context) => authCubit,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Forgot Password'),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
        ),
        body: BlocConsumer<AuthCubit, AuthStates>(
          listenWhen: (previous, current) =>
              previous.forgetPasswordStates != current.forgetPasswordStates,
          listener: (context, state) {
            state.forgetPasswordStates?.when(
              initial: () {},
              loading: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) =>
                      const Center(child: CircularProgressIndicator()),
                );
              },
              success: (data) {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
                Navigator.pushReplacementNamed(
                  context,
                  AppRoutes.otpPage,
                  arguments: authCubit,
                );
              },
              error: (error) {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
                context.showErrorDialog(
                    error ?? "An error occurred, please try again later.",
                    context);
              },
            );
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(16.r),
              child: Form(
                key: authCubit.forgotPasswordFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Email verification",
                      style: theme.textTheme.titleLarge,
                    ),
                    SizedBox(height: 16.h),
                    const Text(
                      "Please enter your code that send to your\nemail address",
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.h),
                    TextFormField(
                      validator: (value) => AppValidators.validateEmail(value),
                      controller: authCubit.forgetPasswordEmailController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                        hintText: 'Enter Your Email',
                        labelText: 'Email',
                      ),
                    ),
                    SizedBox(height: 48.h),
                    ElevatedButton(
                      onPressed: () {
                        if (authCubit.forgotPasswordFormKey.currentState!
                            .validate()) {
                          authCubit.forgetPasswordEmailVerify();
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.all(8.0.r),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Continue"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
