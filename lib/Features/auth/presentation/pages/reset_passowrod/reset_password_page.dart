import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/Features/auth/presentation/manager/auth_cubit.dart';
import 'package:online_exam_app/Features/auth/presentation/manager/auth_states.dart';
import 'package:online_exam_app/core/routes/app_routes.dart';
import 'package:online_exam_app/core/utils/app_validator.dart';
import 'package:online_exam_app/core/utils/extinstions.dart';
import '../../../../../core/di/di.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    AuthCubit authCubit = getIt<AuthCubit>();

    return BlocProvider(
      create: (context) => authCubit,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Reset Password'),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
        ),
        body: BlocConsumer<AuthCubit, AuthStates>(
          listenWhen: (previous, current) =>
              previous.resetPasswordStates != current.resetPasswordStates,
          listener: (context, state) {
            state.resetPasswordStates?.when(
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
                  AppRoutes.layoutScreen,
                  (route) => false,
                );
              },
              error: (error) {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
                context.showErrorDialog(
                  error ?? "An error occurred while resetting password",
                  context,
                );
              },
            );
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Reset Password',
                    style: theme.textTheme.titleLarge,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Password must not be empty and must contain\n6 characters with upper case letter and one\nnumber at least",
                    style: theme.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 32.h),
                  Form(
                    key: authCubit.resetPasswordFormKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: authCubit.forgetPasswordEmailController,
                          validator: (value) =>
                              AppValidators.validateEmail(value),
                          onTapOutside: (_) =>
                              FocusManager.instance.primaryFocus?.unfocus(),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: const InputDecoration(
                            label: Text('Email'),
                            hintText: 'Enter your email',
                          ),
                        ),
                        SizedBox(height: 24.h),
                        TextFormField(
                          controller: authCubit.passwordController,
                          validator: (value) =>
                              AppValidators.validatePassword(value),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onTapOutside: (_) =>
                              FocusManager.instance.primaryFocus?.unfocus(),
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
                            if (authCubit.resetPasswordFormKey.currentState!
                                .validate()) {
                              authCubit.resetPassword();
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.all(8.0.r),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 4.0.w, vertical: 2.0.h),
                                    child: const Text('Continue')),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
