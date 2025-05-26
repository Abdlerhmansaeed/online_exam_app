import 'package:dio/dio.dart';
import 'package:online_exam_app/core/app_manger/app_local_storage/app_local_storage.dart';

class AuthInterceptor extends Interceptor {
  final AppLocalStorage localStorage;

  AuthInterceptor(this.localStorage);

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // Skip adding token for authentication endpoints
    if (options.path.contains('login') ||
        options.path.contains('register') ||
        options.path.contains('forgot-password')) {
      return handler.next(options);
    }

    // Get token from secure storage
    final token = await localStorage.getToken();

    // Add token to headers if it exists
    if (token != null) {
      options.headers['token'] = token;
    }

    return handler.next(options);
  }
}
