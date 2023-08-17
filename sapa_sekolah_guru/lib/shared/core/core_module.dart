import 'package:alice/alice.dart';
import 'package:alice/core/alice_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:sapa_sekolah_guru/shared/core/interceptor/error_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class CoreModule {
  @preResolve
  Future<SharedPreferences> get sharedPreferences =>
      SharedPreferences.getInstance();

  @lazySingleton
  GlobalKey<NavigatorState> get navigatorKey => GlobalKey<NavigatorState>();

  @lazySingleton
  Alice get alice {
    final alice = Alice(
      showNotification: true,
      showInspectorOnShake: true,
      showShareButton: true,
    );
    final GlobalKey<NavigatorState> navigatorKey =
        GetIt.instance.get<GlobalKey<NavigatorState>>();

    alice.setNavigatorKey(navigatorKey);
    return alice;
  }

  @lazySingleton
  Dio get dio {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://lc.sapasekolah.com/api/',
        connectTimeout: 20000,
        sendTimeout: 30000,
        receiveTimeout: 30000,
      ),
    );

    final AliceDioInterceptor aliceDioInterceptor =
        GetIt.instance.get<Alice>().getDioInterceptor();

    dio.interceptors.addAll([
      aliceDioInterceptor,
      ErrorInterceptor(),
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    ]);
    return dio;
  }
}
