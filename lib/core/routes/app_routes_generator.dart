import 'package:flutter/material.dart';
import 'package:online_exam_app/Features/auth/domain/repositories/auth_repo.dart';
import 'package:online_exam_app/Features/auth/presentation/manager/auth_cubit.dart';
import 'package:online_exam_app/Features/home/presentation/pages/home_page.dart';
import 'package:online_exam_app/core/routes/app_routes.dart';

import '../../Features/auth/presentation/pages/forgot_passowrd/forgot_password_page.dart';
import '../../Features/auth/presentation/pages/login/login_page.dart';
import '../../Features/auth/presentation/pages/signup/sign_up_page.dart';

class AppRoutesGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.loginPage:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case AppRoutes.signUpPage:
        return MaterialPageRoute(
            builder: (_) =>  SignUpPage(authCubit: settings.arguments as AuthCubit,),
             );
      case AppRoutes.forgotPass:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordPage());
      case AppRoutes.homePage:
        return MaterialPageRoute(builder: (_) => const HomePage());

      default:
        return MaterialPageRoute(builder: (_) => LoginPage());
    }
  }
}
