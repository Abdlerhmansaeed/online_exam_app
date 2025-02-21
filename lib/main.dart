import 'package:flutter/material.dart';
import 'package:online_exam_app/core/routes/app_routes.dart';
import 'package:online_exam_app/core/routes/app_routes_generator.dart';
import 'package:online_exam_app/core/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}
  
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      theme: AppTheme.appTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.homeScreen,
      onGenerateRoute: AppRoutesGenerator.generateRoute,
    );
  }
}
