import 'package:dio/dio.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    String checkConnections = 'periksa koneksi anda!';
    switch (err.type) {
      case DioErrorType.cancel:
        throw ApiException(
          err.requestOptions,
          'Permintaan ke server dibatalkan',
        );
      case DioErrorType.connectTimeout:
        throw ApiException(
          err.requestOptions,
          'Timeout, $checkConnections',
        );
      case DioErrorType.receiveTimeout:
        throw ApiException(
          err.requestOptions,
          'Timeout, $checkConnections',
        );
      case DioErrorType.sendTimeout:
        throw ApiException(
          err.requestOptions,
          'Timeout, $checkConnections',
        );
      case DioErrorType.other:
        if (err.message.contains('SocketException')) {
          throw ApiException(
            err.requestOptions,
            'Jaringan bermasalah, $checkConnections',
          );
        }
        throw ApiException(
          err.requestOptions,
          'Terjadi kesalahan tak terduga',
        );
      case DioErrorType.response:
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

class ApiException extends DioError {
  @override
  final String message;

  ApiException(
    RequestOptions requestOptions,
    this.message,
  ) : super(requestOptions: requestOptions);

  @override
  String toString() {
    return message;
  }
}
