import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import '../exceptions/failure.dart';

class RequestHandler {
  static Future<Either<Failures, T>> handle<T>(Future<T> Function() request) async {
    try {
      final response = await request();
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } on SocketException {
      return const Left(NetWorkError(errorMessage: "No internet connection. Please check your network and try again."));
    } catch (e) {
      return const Left(ServerFailure(errorMessage: "An unexpected error occurred. Please try again later."));
    }
  }

  static Failures _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetWorkError(errorMessage: "Connection timeout. Please check your internet and try again.");

      case DioExceptionType.badResponse:
        if (e.response != null) {
          final statusCode = e.response!.statusCode;
          final errorMessage = e.response!.data.toString();

          switch (statusCode) {
            case 400:
              return const ServerFailure(errorMessage: "Invalid request. Please check your data and try again.");
            case 401:
              return const ServerFailure(errorMessage: "Session expired. Please log in again.");
            case 403:
              return const ServerFailure(errorMessage: "You do not have permission to perform this action.");
            case 404:
              return const ServerFailure(errorMessage: "The requested resource was not found. Please check your data.");
            case 500:
              return const ServerFailure(errorMessage: "Internal server error. Please try again later.");
            default:
              return ServerFailure(errorMessage: "An error occurred ($statusCode). Please try again.");
          }
        }
        return const ServerFailure(errorMessage: "A server error occurred. Please try again later.");

      case DioExceptionType.cancel:
        return const ServerFailure(errorMessage: "The request was canceled. Please try again.");

      case DioExceptionType.unknown:
      default:
        return const ServerFailure(errorMessage: "An unknown error occurred. Please check your connection and try again.");
    }
  }
}
