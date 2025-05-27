import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:online_exam_app/core/Constant/app_constant.dart';
import 'package:online_exam_app/core/app_manger/app_local_storage/app_local_storage.dart';
import 'package:online_exam_app/core/interceptors/auth_interceptor.dart';
import 'package:online_exam_app/core/services/web_services.dart';

@module
abstract class DioModule {
  @Singleton()
  PrettyDioLogger providePrettyLogger() {
    return PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
    );
  }

  @Singleton()
  AuthInterceptor provideAuthInterceptor(AppLocalStorage localStorage) {
    return AuthInterceptor(localStorage);
  }

  @Singleton()
  Dio provideDio(
      PrettyDioLogger prettyLogger, AuthInterceptor authInterceptor) {
    var dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 60),
        baseUrl: ApiConstants.baseUrl,
      ),
    );

    dio.interceptors.add(authInterceptor);
    dio.interceptors.add(prettyLogger);

    return dio;
  }

  @Singleton()
  WebServices provideWebServices(Dio dio) {
    return WebServices(dio);
  }
}
