
import 'api_result.dart';

ApiResult<T> handleResponse<T>(ApiResult<T> response) {
  return response.when(
    success: (data) => ApiSuccess(data),
    failure: (message) => ApiFailure(message),
  );
}

ApiResult<R> handleTransformedResponse<T, R>(
  ApiResult<T> response,
  R Function(T data) transform,
) {
  return response.map(transform);
}
