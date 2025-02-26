import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/di/di.dart';
import 'package:online_exam_app/core/routes/app_routes.dart';
import 'package:online_exam_app/core/routes/app_routes_generator.dart';
import 'package:online_exam_app/core/theme/app_theme.dart';
import 'package:online_exam_app/my_bloc_observer.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
    configureDependencies(); 
  runApp(const MyApp());
}
  
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      child: MaterialApp(
        
        theme: AppTheme.appTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.homeScreen,
        onGenerateRoute: AppRoutesGenerator.generateRoute,
      ),
    );
  }
}
