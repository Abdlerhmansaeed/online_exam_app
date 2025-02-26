import 'package:flutter/material.dart';
import 'package:online_exam_app/Features/auth/presentation/manager/auth_cubit.dart';
import 'package:online_exam_app/Features/auth/presentation/pages/forgot_passowrd/forgot_password_page.dart';
import 'package:online_exam_app/Features/auth/presentation/pages/login/login_page.dart';
import 'package:online_exam_app/Features/auth/presentation/pages/otp_page/otp_verification_page.dart';
import 'package:online_exam_app/Features/auth/presentation/pages/reset_passowrod/reset_password_page.dart';
import 'package:online_exam_app/Features/auth/presentation/pages/signup/sign_up_page.dart';
import 'package:online_exam_app/Features/home/presentation/pages/home_screen.dart';
import 'package:online_exam_app/Features/profile/presentation/pages/profile_page.dart';
import 'package:online_exam_app/Features/result/presentation/pages/result_page.dart';
import 'package:online_exam_app/core/routes/app_routes.dart';

import '../../Features/home/presentation/pages/home_tab.dart';
import '../../Features/home/presentation/pages/subject_detail.dart';

class AppRoutesGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.loginPage:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case AppRoutes.signUpPage:
        return MaterialPageRoute(
          builder: (_) => SignUpPage(authCubit: settings.arguments as AuthCubit),
        );
      case AppRoutes.forgotPass:
        return MaterialPageRoute(
          builder: (_) => ForgotPasswordPage(authCubit: settings.arguments as AuthCubit),
        );
      case AppRoutes.homePage:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case AppRoutes.otpPage:
        return MaterialPageRoute(
          builder: (_) => OtpVerificationPage(authCubit: settings.arguments as AuthCubit),
        );
      case AppRoutes.resetPasswordPage:
        return MaterialPageRoute(
          builder: (_) => ResetPasswordPage(authCubit: settings.arguments as AuthCubit),
        );
      case AppRoutes.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case AppRoutes.profilePage:
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      case AppRoutes.resultPage:
        return MaterialPageRoute(builder: (_) => const ResultPage());
      case AppRoutes.subjectDetails:
        return MaterialPageRoute(builder: (_) => const SubjectDetail());
      default:
        return MaterialPageRoute(builder: (_) => const LoginPage());
    }
  }
}
