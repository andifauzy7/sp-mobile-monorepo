// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:alice/alice.dart' as _i3;
import 'package:dio/dio.dart' as _i4;
import 'package:flutter/material.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:sapa_sekolah_guru/bloc/add_activity/add_activity_bloc.dart'
    as _i12;
import 'package:sapa_sekolah_guru/bloc/add_lesson/add_lesson_bloc.dart' as _i13;
import 'package:sapa_sekolah_guru/bloc/get_activities/get_activities_bloc.dart'
    as _i14;
import 'package:sapa_sekolah_guru/bloc/get_lessons/get_lessons_bloc.dart'
    as _i15;
import 'package:sapa_sekolah_guru/bloc/login/login_bloc.dart' as _i9;
import 'package:sapa_sekolah_guru/bloc/logout/logout_bloc.dart' as _i10;
import 'package:sapa_sekolah_guru/presentation/splash/cubit/splash_cubit.dart'
    as _i11;
import 'package:sapa_sekolah_guru/repositories/auth_repository.dart' as _i7;
import 'package:sapa_sekolah_guru/repositories/lesson_repository.dart' as _i8;
import 'package:sapa_sekolah_guru/shared/core/core_module.dart' as _i16;
import 'package:shared_preferences/shared_preferences.dart' as _i6;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final coreModule = _$CoreModule();
    gh.lazySingleton<_i3.Alice>(() => coreModule.alice);
    gh.lazySingleton<_i4.Dio>(() => coreModule.dio);
    gh.lazySingleton<_i5.GlobalKey<_i5.NavigatorState>>(
        () => coreModule.navigatorKey);
    await gh.factoryAsync<_i6.SharedPreferences>(
      () => coreModule.sharedPreferences,
      preResolve: true,
    );
    gh.lazySingleton<_i7.AuthRepository>(() => _i7.AuthRepositoryImpl(
          dio: gh<_i4.Dio>(),
          sharedPreferences: gh<_i6.SharedPreferences>(),
        ));
    gh.lazySingleton<_i8.LessonRepository>(() => _i8.LessonRepositoryImpl(
          dio: gh<_i4.Dio>(),
          sharedPreferences: gh<_i6.SharedPreferences>(),
        ));
    gh.factory<_i9.LoginBloc>(
        () => _i9.LoginBloc(authRepository: gh<_i7.AuthRepository>()));
    gh.factory<_i10.LogoutBloc>(
        () => _i10.LogoutBloc(authRepository: gh<_i7.AuthRepository>()));
    gh.factory<_i11.SplashCubit>(
        () => _i11.SplashCubit(authRepository: gh<_i7.AuthRepository>()));
    gh.factory<_i12.AddActivityBloc>(() =>
        _i12.AddActivityBloc(lessonRepository: gh<_i8.LessonRepository>()));
    gh.factory<_i13.AddLessonBloc>(
        () => _i13.AddLessonBloc(lessonRepository: gh<_i8.LessonRepository>()));
    gh.factory<_i14.GetActivitiesBloc>(() =>
        _i14.GetActivitiesBloc(lessonRepository: gh<_i8.LessonRepository>()));
    gh.factory<_i15.GetLessonsBloc>(() =>
        _i15.GetLessonsBloc(lessonRepository: gh<_i8.LessonRepository>()));
    return this;
  }
}

class _$CoreModule extends _i16.CoreModule {}