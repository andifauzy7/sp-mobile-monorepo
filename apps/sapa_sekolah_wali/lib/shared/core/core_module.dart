import 'package:flutter/material.dart';
import 'package:sapa_core/interceptor/error_interceptor.dart';
import 'package:sapa_core/sapa_core.dart';

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
        baseUrl: 'https://lc.sapasekolah.com/api/parent/',
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