import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:online_exam_app/Features/auth/presentation/manager/auth_cubit.dart';
import 'package:online_exam_app/Features/auth/presentation/manager/auth_states.dart';
import 'package:online_exam_app/core/Constant/app_regx.dart';
import 'package:online_exam_app/core/di/di.dart';
import 'package:online_exam_app/core/routes/app_routes.dart';
import 'package:online_exam_app/core/theme/app_colors.dart';
import 'package:online_exam_app/core/utils/app_validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthCubit>(),
      child: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (didPop) {
            SystemNavigator.pop();
          }
        },
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: const Text('Login'),
                  leading: IconButton(
                    onPressed: () => SystemNavigator.pop(),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  ),
                ),
                BlocConsumer<AuthCubit, AuthStates>(
                  listener: (context, state) {
                    state.loginStates?.whenOrNull(
                      success: (_) {
                        // Hide keyboard and any open dialogs
                        FocusManager.instance.primaryFocus?.unfocus();
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }

                        // Navigate to home and clear routes
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRoutes.layoutScreen,
                          (route) => false,
                        );
                      },
                      error: (message) {
                        // Hide loading dialog if visible
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }

                        // Show styled error dialog
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: AppColors.white.withOpacity(0.9),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.error_outline_rounded,
                                    color: Colors.red,
                                    size: 50.w,
                                  ),
                                  SizedBox(height: 16.h),
                                  Text(
                                    message ?? "An error occurred",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 16.h),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.blue,
                                        foregroundColor: Colors.white,
                                      ),
                                      onPressed: () => Navigator.pop(context),
                                      child: const Padding(
                                        padding: EdgeInsets.all(12.0),
                                        child: Text('OK'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      loading: () {
                        // Hide keyboard
                        FocusManager.instance.primaryFocus?.unfocus();

                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) =>
                              const Center(child: CircularProgressIndicator()),
                        );
                      },
                    );
                  },
                  builder: (context, state) {
                    return SliverPadding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.h, horizontal: 20.w),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate.fixed([
                          SizedBox(height: 16.h),

                          // App Logo or Login Image
                          Center(
                            child: Icon(Icons.school,
                                size: 80.w, color: AppColors.blue),
                          ),

                          SizedBox(height: 32.h),

                          // Title
                          Text(
                            'Welcome Back',
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.blue,
                            ),
                            textAlign: TextAlign.center,
                          ),

                          SizedBox(height: 8.h),

                          Text(
                            'Sign in to continue',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: AppColors.gray,
                            ),
                            textAlign: TextAlign.center,
                          ),

                          SizedBox(height: 32.h),

                          // Login Form
                          Form(
                            key: context.read<AuthCubit>().loginFormKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Email Field
                                TextFormField(
                                  validator: (value) =>
                                      AppValidators.validateEmail(value),
                                  onTapOutside: (_) => FocusManager
                                      .instance.primaryFocus
                                      ?.unfocus(),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller:
                                      context.read<AuthCubit>().emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    hintText: 'Enter Your Email',
                                    labelText: 'Email',
                                    prefixIcon: const Icon(Icons.email_outlined,
                                        color: AppColors.gray),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                  ),
                                ),

                                SizedBox(height: 16.h),

                                // Password Field
                                TextFormField(
                                  validator: (value) =>
                                      AppValidators.validatePassword(value),
                                  onTapOutside: (_) => FocusManager
                                      .instance.primaryFocus
                                      ?.unfocus(),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  obscureText: _obscurePassword,
                                  controller: context
                                      .read<AuthCubit>()
                                      .passwordController,
                                  decoration: InputDecoration(
                                    hintText: 'Enter Your Password',
                                    labelText: 'Password',
                                    prefixIcon: const Icon(Icons.lock_outline,
                                        color: AppColors.gray),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _obscurePassword
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: AppColors.gray,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _obscurePassword = !_obscurePassword;
                                        });
                                      },
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                  ),
                                ),

                                SizedBox(height: 8.h),

                                // Remember me & Forgot password
                                Row(
                                  children: [
                                    ValueListenableBuilder(
                                      valueListenable: context
                                          .read<AuthCubit>()
                                          .checkBoxValue,
                                      builder: (context, value, child) {
                                        return Checkbox(
                                          value: value,
                                          side: const BorderSide(
                                              color: AppColors.gray),
                                          activeColor: AppColors.blue,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.r),
                                          ),
                                          overlayColor:
                                              const WidgetStatePropertyAll(
                                                  Colors.transparent),
                                          onChanged: (newValue) {
                                            if (newValue != null) {
                                              context
                                                  .read<AuthCubit>()
                                                  .rememberMe(newValue);
                                            }
                                          },
                                        );
                                      },
                                    ),
                                    Text(
                                      'Remember me',
                                      style: TextStyle(fontSize: 14.sp),
                                    ),
                                    const Spacer(),
                                    TextButton(
                                      style: const ButtonStyle(
                                        overlayColor: MaterialStatePropertyAll(
                                            Colors.transparent),
                                      ),
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, AppRoutes.forgotPass);
                                      },
                                      child: Text(
                                        'Forgot password?',
                                        style: TextStyle(
                                          color: AppColors.blue,
                                          fontSize: 14.sp,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 24.h),

                                // Login Button
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.blue,
                                    foregroundColor: Colors.white,
                                    padding:
                                        EdgeInsets.symmetric(vertical: 16.h),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (context
                                        .read<AuthCubit>()
                                        .loginFormKey
                                        .currentState!
                                        .validate()) {
                                      context.read<AuthCubit>().login();
                                    }
                                  },
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),

                                SizedBox(height: 24.h),

                                // Sign Up Link
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Don't have an account?",
                                      style: TextStyle(fontSize: 14.sp),
                                    ),
                                    TextButton(
                                      style: const ButtonStyle(
                                        overlayColor: MaterialStatePropertyAll(
                                            Colors.transparent),
                                      ),
                                      onPressed: () {
                                        Navigator.pushNamed(
                                          context,
                                          AppRoutes.signUpPage,
                                          arguments: context.read<AuthCubit>(),
                                        );
                                      },
                                      child: Text(
                                        'Sign up',
                                        style: TextStyle(
                                          color: AppColors.blue,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
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
        ),
      ),
    );
  }
}
