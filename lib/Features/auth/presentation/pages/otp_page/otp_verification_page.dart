import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/Features/auth/presentation/manager/auth_cubit.dart';
import 'package:online_exam_app/Features/auth/presentation/manager/auth_states.dart';
import 'package:online_exam_app/core/routes/app_routes.dart';
import 'package:online_exam_app/core/theme/app_colors.dart';
import 'package:online_exam_app/core/utils/extinstions.dart';
import 'package:pinput/pinput.dart';

import '../../../../../core/di/di.dart';

class OtpVerificationPage extends StatelessWidget {
  const OtpVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    AuthCubit authCubit = getIt<AuthCubit>();

    return BlocProvider(
      create: (context) => authCubit,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Password'),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
        ),
        body: BlocConsumer<AuthCubit, AuthStates>(
          listenWhen: (previous, current) =>
              previous.otpStates != current.otpStates,
          listener: (context, state) {
            state.otpStates?.when(
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
                  Navigator.pop(context); // Close loading dialog
                }
                Navigator.pushReplacementNamed(
                  context,
                  AppRoutes.resetPasswordPage,
                  arguments: authCubit,
                );
              },
              error: (error) {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context); // Close loading dialog if any
                }
                context.showErrorDialog(
                  error ?? "An error occurred during verification",
                  context,
                );
              },
            );
          },
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Email verification",
                    style: theme.textTheme.titleLarge,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Please enter the code sent to your email address",
                    style: theme.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 32.h),
                  Pinput(
                    length: 6,
                    keyboardType: TextInputType.number,
                    showCursor: true,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    autofocus: true,
                    controller: authCubit.otpController,
                    onCompleted: (value) {
                      authCubit.resetCodeVerify();
                    },
                    defaultPinTheme: PinTheme(
                      width: 48.w,
                      height: 48.h,
                      decoration: BoxDecoration(
                        color: AppColors.lightBlue,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      textStyle: theme.textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Didn't receive the code? "),
                      TextButton(
                        style: const ButtonStyle(
                          overlayColor:
                              WidgetStatePropertyAll(Colors.transparent),
                        ),
                        onPressed: () {
                          authCubit.forgetPasswordEmailVerify();
                        },
                        child: const Text('Resend'),
                      ),
                    ],
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
