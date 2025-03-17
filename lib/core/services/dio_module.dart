import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/core/Constant/app_constant.dart';
import 'package:online_exam_app/core/services/web_services.dart';

@module
abstract class DioModule{

   static const int connectionTimeOut = 60;
  @Singleton()
  LogInterceptor provideLogger(){
    return LogInterceptor();
  }
  @Singleton()
  Dio provideDio(LogInterceptor logInterceptor){
    var dio = Dio(
        BaseOptions(
          connectTimeout: const Duration(seconds: connectionTimeOut),
          baseUrl: ApiConstants.baseUrl,
        )
    );
    dio.interceptors.add(logInterceptor);
    return dio;
  }
  @Singleton()
  WebServices provideWebServices(Dio dio){
    return WebServices(dio);
  }

}