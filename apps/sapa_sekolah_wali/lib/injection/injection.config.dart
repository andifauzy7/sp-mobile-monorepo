// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i7;
import 'package:flutter/material.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:sapa_core/sapa_core.dart' as _i3;
import 'package:sapa_sekolah_wali/application/bloc/detail_payment/detail_payment_bloc.dart'
    as _i25;
import 'package:sapa_sekolah_wali/application/bloc/list_payment/list_payment_bloc.dart'
    as _i20;
import 'package:sapa_sekolah_wali/application/bloc/news/news_bloc.dart' as _i23;
import 'package:sapa_sekolah_wali/bloc/change_password/change_password_bloc.dart'
    as _i13;
import 'package:sapa_sekolah_wali/bloc/get_lesson_plan_detail/get_lesson_plan_detail_bloc.dart'
    as _i26;
import 'package:sapa_sekolah_wali/bloc/get_lesson_plans/get_lesson_plans_bloc.dart'
    as _i27;
import 'package:sapa_sekolah_wali/bloc/get_student_detail/get_student_detail_bloc.dart'
    as _i16;
import 'package:sapa_sekolah_wali/bloc/get_students/get_students_bloc.dart'
    as _i17;
import 'package:sapa_sekolah_wali/bloc/get_teachers/get_teachers_bloc.dart'
    as _i18;
import 'package:sapa_sekolah_wali/bloc/login/login_bloc.dart' as _i21;
import 'package:sapa_sekolah_wali/bloc/logout/logout_bloc.dart' as _i22;
import 'package:sapa_sekolah_wali/presentation/splash/cubit/splash_cubit.dart'
    as _i24;
import 'package:sapa_sekolah_wali/repositories/auth_repository.dart' as _i12;
import 'package:sapa_sekolah_wali/repositories/lesson_repository.dart' as _i19;
import 'package:sapa_sekolah_wali/repositories/news/new_repository_impl.dart'
    as _i9;
import 'package:sapa_sekolah_wali/repositories/news/news_repository.dart'
    as _i8;
import 'package:sapa_sekolah_wali/repositories/payment/detail_payment_repository.dart'
    as _i14;
import 'package:sapa_sekolah_wali/repositories/payment/detail_payment_repository_impl.dart'
    as _i15;
import 'package:sapa_sekolah_wali/repositories/payment/list_payment_repository.dart'
    as _i5;
import 'package:sapa_sekolah_wali/repositories/payment/list_payment_repository_impl.dart'
    as _i6;
import 'package:sapa_sekolah_wali/repositories/student_repository.dart' as _i10;
import 'package:sapa_sekolah_wali/repositories/teacher_repository.dart' as _i11;
import 'package:sapa_sekolah_wali/shared/core/core_module.dart' as _i28;

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
    gh.lazySingleton<_i3.Dio>(() => coreModule.dio);
    gh.lazySingleton<_i4.GlobalKey<_i4.NavigatorState>>(
        () => coreModule.navigatorKey);
    gh.lazySingleton<_i5.ListPaymentRepository>(
        () => _i6.ListPaymentRepositoryImpl(gh<_i7.Dio>()));
    gh.lazySingleton<_i8.NewsRepository>(
        () => _i9.NewsRepositoryImpl(gh<_i7.Dio>()));
    await gh.factoryAsync<_i3.SharedPreferences>(
      () => coreModule.sharedPreferences,
      preResolve: true,
    );
    gh.lazySingleton<_i10.StudentRepository>(() => _i10.StudentRepositoryImpl(
          dio: gh<_i3.Dio>(),
          sharedPreferences: gh<_i3.SharedPreferences>(),
        ));
    gh.lazySingleton<_i11.TeacherRepository>(() => _i11.TeacherRepositoryImpl(
          dio: gh<_i3.Dio>(),
          sharedPreferences: gh<_i3.SharedPreferences>(),
        ));
    gh.lazySingleton<_i12.AuthRepository>(() => _i12.AuthRepositoryImpl(
          dio: gh<_i3.Dio>(),
          sharedPreferences: gh<_i3.SharedPreferences>(),
        ));
    gh.factory<_i13.ChangePasswordBloc>(() =>
        _i13.ChangePasswordBloc(authRepository: gh<_i12.AuthRepository>()));
    gh.lazySingleton<_i14.DetailPaymentRepository>(
        () => _i15.DetailPaymentRepositoryImpl(gh<_i7.Dio>()));
    gh.factory<_i16.GetStudentDetailBloc>(() => _i16.GetStudentDetailBloc(
        studentRepository: gh<_i10.StudentRepository>()));
    gh.factory<_i17.GetStudentsBloc>(() =>
        _i17.GetStudentsBloc(studentRepository: gh<_i10.StudentRepository>()));
    gh.factory<_i18.GetTeachersBloc>(() =>
        _i18.GetTeachersBloc(teacherRepository: gh<_i11.TeacherRepository>()));
    gh.lazySingleton<_i19.LessonRepository>(() => _i19.LessonRepositoryImpl(
          dio: gh<_i3.Dio>(),
          sharedPreferences: gh<_i3.SharedPreferences>(),
        ));
    gh.factory<_i20.ListPaymentBloc>(
        () => _i20.ListPaymentBloc(gh<_i5.ListPaymentRepository>()));
    gh.factory<_i21.LoginBloc>(
        () => _i21.LoginBloc(authRepository: gh<_i12.AuthRepository>()));
    gh.factory<_i22.LogoutBloc>(
        () => _i22.LogoutBloc(authRepository: gh<_i12.AuthRepository>()));
    gh.factory<_i23.NewsBloc>(() => _i23.NewsBloc(gh<_i8.NewsRepository>()));
    gh.factory<_i24.SplashCubit>(
        () => _i24.SplashCubit(authRepository: gh<_i12.AuthRepository>()));
    gh.factory<_i25.DetailPaymentBloc>(
        () => _i25.DetailPaymentBloc(gh<_i14.DetailPaymentRepository>()));
    gh.factory<_i26.GetLessonPlanDetailBloc>(() => _i26.GetLessonPlanDetailBloc(
        lessonRepository: gh<_i19.LessonRepository>()));
    gh.factory<_i27.GetLessonPlansBloc>(() =>
        _i27.GetLessonPlansBloc(lessonRepository: gh<_i19.LessonRepository>()));
    return this;
  }
}

class _$CoreModule extends _i28.CoreModule {}
