import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart' show debugPrint;

Future<void> handleCubitStates<T>({
  required Future<Either<String, T>> Function() request,
  required void Function(T) onSuccess,
  required void Function(String) onError,
  required void Function() onLoading,
}) async {
  onLoading();
  try {
    final result = await request();
    result.fold(
          (failure) => onError(failure),
          (success) => onSuccess(success),
    );
  } catch (e) {
    debugPrint("Error: $e");
    onError(e.toString());
  }
}
