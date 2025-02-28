import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/Features/auth/presentation/manager/auth_cubit.dart';
import 'package:online_exam_app/Features/auth/presentation/manager/auth_states.dart';
import 'package:online_exam_app/core/routes/app_routes.dart';
import 'package:online_exam_app/core/theme/app_colors.dart';
import 'package:pinput/pinput.dart';

import '../../../../../core/base_states/base_states.dart';
import '../../../../../core/di/di.dart';

class OtpVerificationPage extends StatelessWidget {
  OtpVerificationPage({super.key});

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
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
        ),
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {


            if (state.otpStates is SuccessState) {
              Navigator.pushReplacementNamed(
                  context, AppRoutes.resetPasswordPage,
                  arguments: authCubit);
            } else if (state.otpStates is ErrorState) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text((state.otpStates as ErrorState).error?? ""),
                  );
                },
              );
            } else if (state.otpStates is LoadingState) {
              showDialog(
                context: context,
                barrierDismissible: false, // Prevent closing while loading
                builder: (_) =>
                    const Center(child: CircularProgressIndicator()),
              );
            }
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
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0.r),
                              child: const Text(
                                'Resend',
                              ),
                            ),
                          ],
                        ),
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
