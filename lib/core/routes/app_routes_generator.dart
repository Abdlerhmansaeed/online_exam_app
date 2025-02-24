import 'package:flutter/material.dart';
import 'package:online_exam_app/Features/auth/presentation/manager/auth_cubit.dart';
import 'package:online_exam_app/Features/auth/presentation/pages/otp_page/otp_verification_page.dart';
import 'package:online_exam_app/Features/home/presentation/pages/home_page.dart';
import 'package:online_exam_app/core/routes/app_routes.dart';

import '../../Features/auth/presentation/pages/forgot_passowrd/forgot_password_page.dart';
import '../../Features/auth/presentation/pages/login/login_page.dart';
import '../../Features/auth/presentation/pages/reset_passowrod/reset_password_page.dart';
import '../../Features/auth/presentation/pages/signup/sign_up_page.dart';

class AppRoutesGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.loginPage:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case AppRoutes.signUpPage:
        return MaterialPageRoute(
            builder: (_) =>  SignUpPage(authCubit: settings.arguments as AuthCubit,),
             );
      case AppRoutes.forgotPass:
        return MaterialPageRoute(builder: (_) =>  ForgotPasswordPage(authCubit: settings.arguments as AuthCubit,));
      case AppRoutes.homePage:
        return MaterialPageRoute(builder: (_) => const HomePage());
        case AppRoutes.otpPage:
        return MaterialPageRoute(builder: (_) =>  OtpVerificationPage(authCubit: settings.arguments as AuthCubit,));
      case AppRoutes.resetPasswordPage:
        return MaterialPageRoute(builder: (_) =>  ResetPasswordPage(authCubit: settings.arguments as AuthCubit,));
      default:
        return MaterialPageRoute(builder: (_) => const DefaultRoute());
    }
  }
}

class DefaultRoute extends StatelessWidget {
  const DefaultRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("There is No data"),
        Icon(Icons.crisis_alert_rounded)
      ],
    );
  }
}

