import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/routes/app_routes.dart';
import 'package:online_exam_app/core/routes/app_routes_generator.dart';
import 'package:online_exam_app/core/theme/app_theme.dart';

import 'core/di/di.dart';
import 'core/services/shared_prefs.dart';


String? token ;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  token = await SharedPrefs().getString("token");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          theme: AppTheme.appTheme,
          debugShowCheckedModeBanner: false,
          initialRoute:  token != null ? AppRoutes.homeScreen : AppRoutes.loginPage,
          onGenerateRoute: AppRoutesGenerator.generateRoute,
        );
      },
    );
  }
}
