import 'request_handler.dart';
import 'api_result.dart';

class RetrofitHandler {
  static Future<ApiResult<T>> handle<T>(Future<T> Function() retrofitCall) {
    return RequestHandler.handle(retrofitCall);
  }
}
