import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import '../exceptions/failure.dart';

class RequestHandler {
  static Future<Either<Failures, T>> handle<T>(
      Future<T> Function() request) async {
    try {
      final response = await request();
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } on SocketException {
      return const Left(NetWorkError(
          errorMessage:
              "No internet connection. Please check your network and try again."));
    } catch (e) {
      // Consider logging the error here for debugging purposes
      // print('Unexpected error in RequestHandler: $e');
      return const Left(ServerFailure(
          errorMessage:
              "An unexpected error occurred. Please try again later."));
    }
  }

  static Failures _handleDioError(DioException e) {
    const String genericNetworkErrorMessage =
        "There seems to be a problem with the network. Please check your connection and try again.";
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetWorkError(
            errorMessage:
                "Connection timeout. Please check your internet and try again.");

      case DioExceptionType.badResponse:
        if (e.response != null) {
          final statusCode = e.response!.statusCode;
          final errorMessage = _extractErrorMessage(e.response!);
          // You could create more specific Failure types here e.g. AuthenticationFailure, NotFoundFailure
          switch (statusCode) {
            case 400: // Bad Request
              return ServerFailure(
                  errorMessage: errorMessage ??
                      "The request was invalid. Please check the data and try again.");
            case 401: // Unauthorized
              return ServerFailure(
                  errorMessage: errorMessage ??
                      "Authentication failed. Please log in again.");
            case 403: // Forbidden
              return ServerFailure(
                  errorMessage: errorMessage ??
                      "You don't have permission to access this resource.");
            case 404: // Not Found
              return ServerFailure(
                  errorMessage:
                      errorMessage ?? "The requested resource was not found.");
            case 500: // Internal Server Error
            case 502: // Bad Gateway
            case 503: // Service Unavailable
              return ServerFailure(
                  errorMessage: errorMessage ??
                      "The server is currently unavailable. Please try again later.");
            default:
              return ServerFailure(
                  errorMessage: errorMessage ??
                      "An error occurred (Status code: $statusCode). Please try again.");
          }
        }
        return const ServerFailure(
            errorMessage: "A server error occurred. Please try again later.");

      case DioExceptionType.cancel:
        return const ServerFailure(
            errorMessage: "The request was canceled. Please try again.");

      case DioExceptionType.connectionError:
        return const NetWorkError(
            errorMessage:
                "Connection error. Please check your internet connection.");

      case DioExceptionType.unknown:
      default:
        if (e.error is SocketException) {
          return const NetWorkError(
              errorMessage:
                  "No internet connection. Please check your network and try again.");
        }
        return ServerFailure(
            errorMessage:
                "An unknown error occurred. ${e.message ?? genericNetworkErrorMessage}");
    }
  }

  /// Function to extract error message from API response
  static String? _extractErrorMessage(Response response) {
    try {
      if (response.data is Map<String, dynamic>) {
        final data = response.data as Map<String, dynamic>;
        // Common error message keys, add more if your API uses different ones
        return data['message']?.toString() ??
            data['error']?.toString() ??
            data['detail']?.toString();
      } else if (response.data is String &&
          (response.data as String).isNotEmpty) {
        return response.data as String;
      }
    } catch (ex) {
       debugPrint('Error parsing error message: $ex');
      return null;
    }
    return null;
  }
}
