import 'package:dio/dio.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    String checkConnections = 'periksa koneksi anda!';
    switch (err.type) {
      case DioExceptionType.cancel:
        throw ApiException(
          err.requestOptions,
          'Permintaan ke server dibatalkan',
        );
      case DioExceptionType.connectionTimeout:
        throw ApiException(
          err.requestOptions,
          'Timeout, $checkConnections',
        );
      case DioExceptionType.receiveTimeout:
        throw ApiException(
          err.requestOptions,
          'Timeout, $checkConnections',
        );
      case DioExceptionType.sendTimeout:
        throw ApiException(
          err.requestOptions,
          'Timeout, $checkConnections',
        );
      case DioExceptionType.connectionError:
        throw ApiException(
          err.requestOptions,
          'Jaringan bermasalah, $checkConnections',
        );
      case DioExceptionType.unknown:
      case DioExceptionType.badResponse:
        String message = _handleError(
          err.response?.statusCode,
          err.response?.data,
        );
        throw ApiException(
          err.requestOptions,
          message,
        );
      default:
        throw ApiException(
          err.requestOptions,
          'Sepertinya ada yang salah',
        );
    }
  }

  String _handleError(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 413:
        return 'Request file too large';
      case 422:
      case 429:
        return error['message'];
      case 500:
        return 'Internal server error';
      case 502:
        return 'Bad gateway';
      default:
        return '[$statusCode] Ups! Ada yang tidak beres';
    }
  }
}

class ApiException extends DioException {
  ApiException(
    RequestOptions requestOptions,
    String message,
  ) : super(requestOptions: requestOptions, message: message);

  @override
  String toString() {
    return message ?? '';
  }
}
