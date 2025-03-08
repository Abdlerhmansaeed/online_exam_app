import 'package:dartz/dartz.dart';

import '../exceptions/failure.dart';

Either<String, T> handleResponse<T>(Either<Failures, T> response) {
  return response.fold(
        (failure) => left(failure.errorMessage),
        (data) => right(data),
  );
}