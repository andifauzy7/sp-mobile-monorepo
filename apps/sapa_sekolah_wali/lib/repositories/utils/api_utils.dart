import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@module
abstract class ApiUtils {
  @LazySingleton()
  Dio dio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://lc.sapasekolah.com/api/parent/',
        connectTimeout: 60 * 1000,
        sendTimeout: 60 * 1000,
        receiveTimeout: 60 * 1000,
        responseType: ResponseType.json,
        headers: {
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.addAll([
      PrettyDioLogger(
        compact: true,
        error: true,
        request: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        requestHeader: true,
      )
    ]);

    return dio;
  }
}
