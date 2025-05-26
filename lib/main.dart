import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart'; 
import 'package:online_exam_app/core/app_manger/app_manger.dart';
import 'package:online_exam_app/core/routes/app_routes.dart';
import 'package:online_exam_app/core/routes/app_routes_generator.dart';
import 'package:online_exam_app/core/theme/app_theme.dart';
import 'package:online_exam_app/my_bloc_observer.dart';
import 'core/di/di.dart';

void main() async {
  final initialRoute = await initializeApp();
  runApp(
    BlocProvider.value(
      value: getIt<AppManger>(),
      child: MyApp(initialRoute: initialRoute),
    ),
  );
}

class MyApp extends StatelessWidget {

  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

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
          initialRoute: initialRoute,
          onGenerateRoute: AppRoutesGenerator.generateRoute,
        );
      },
    );
  }
}


Future<void> _initializeHiveAdapters() async {
  await Hive.initFlutter();
}

Future<String> _initializeAppManagerAndGetInitialRoute() async {
  final appManager = getIt<AppManger>();
  await appManager.getUserLoggedInState();
  return appManager.state.isLoggedIn
      ? AppRoutes.layoutScreen
      : AppRoutes.loginPage;
}

Future<String> initializeApp() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  configureDependencies(); // Dependency Injection
  await _initializeHiveAdapters(); // Initialize Hive and Register Adapters ONLY
  Bloc.observer = MyBlocObserver();

  final initialRoute =
      await _initializeAppManagerAndGetInitialRoute(); // App Manager and Initial Route

  FlutterNativeSplash.remove();
  return initialRoute;
}