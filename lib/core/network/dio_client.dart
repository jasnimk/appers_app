import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../config/app_config.dart';

class DioClient {
  static Dio? _dio;

  static Dio get instance {
    if (_dio == null) {
      _dio = Dio(
        BaseOptions(
          baseUrl: AppConfig.baseUrl,
          connectTimeout: AppConfig.connectionTimeout,
          receiveTimeout: AppConfig.receiveTimeout,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      // Add interceptors
      _dio!.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90,
        ),
      );

      // Add error interceptor
      _dio!.interceptors.add(
        InterceptorsWrapper(
          onError: (DioException error, ErrorInterceptorHandler handler) {
            // Handle errors globally
            String errorMessage = _handleError(error);
            handler.next(
              DioException(
                requestOptions: error.requestOptions,
                error: errorMessage,
                type: error.type,
              ),
            );
          },
        ),
      );
    }
    return _dio!;
  }

  static String _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timeout. Please check your internet connection.';
      case DioExceptionType.badResponse:
        return _handleStatusCode(error.response?.statusCode);
      case DioExceptionType.cancel:
        return 'Request cancelled';
      case DioExceptionType.connectionError:
        return 'No internet connection';
      case DioExceptionType.badCertificate:
        return 'Certificate error';
      case DioExceptionType.unknown:
        return 'Something went wrong. Please try again.';
    }
  }

  static String _handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 401:
        return 'Unauthorized';
      case 403:
        return 'Forbidden';
      case 404:
        return 'Not found';
      case 500:
        return 'Internal server error';
      case 503:
        return 'Service unavailable';
      default:
        return 'Something went wrong';
    }
  }
}
