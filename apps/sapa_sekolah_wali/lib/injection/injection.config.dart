// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:sapa_core/sapa_core.dart' as _i3;
import 'package:sapa_sekolah_wali/bloc/change_password/change_password_bloc.dart'
    as _i8;
import 'package:sapa_sekolah_wali/bloc/get_lesson_plan_detail/get_lesson_plan_detail_bloc.dart'
    as _i18;
import 'package:sapa_sekolah_wali/bloc/get_lesson_plans/get_lesson_plans_bloc.dart'
    as _i19;
import 'package:sapa_sekolah_wali/bloc/get_payment_detail/get_payment_detail_bloc.dart'
    as _i20;
import 'package:sapa_sekolah_wali/bloc/get_payments/get_payments_bloc.dart'
    as _i21;
import 'package:sapa_sekolah_wali/bloc/get_student_detail/get_student_detail_bloc.dart'
    as _i9;
import 'package:sapa_sekolah_wali/bloc/get_students/get_students_bloc.dart'
    as _i10;
import 'package:sapa_sekolah_wali/bloc/get_teacher_detail/get_teacher_detail_bloc.dart'
    as _i11;
import 'package:sapa_sekolah_wali/bloc/get_teachers/get_teachers_bloc.dart'
    as _i12;
import 'package:sapa_sekolah_wali/bloc/login/login_bloc.dart' as _i14;
import 'package:sapa_sekolah_wali/bloc/logout/logout_bloc.dart' as _i15;
import 'package:sapa_sekolah_wali/presentation/splash/cubit/splash_cubit.dart'
    as _i17;
import 'package:sapa_sekolah_wali/repositories/auth_repository.dart' as _i7;
import 'package:sapa_sekolah_wali/repositories/lesson_repository.dart' as _i13;
import 'package:sapa_sekolah_wali/repositories/payment_repository.dart' as _i16;
import 'package:sapa_sekolah_wali/repositories/student_repository.dart' as _i5;
import 'package:sapa_sekolah_wali/repositories/teacher_repository.dart' as _i6;
import 'package:sapa_sekolah_wali/shared/core/core_module.dart' as _i22;

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
    await gh.factoryAsync<_i3.SharedPreferences>(
      () => coreModule.sharedPreferences,
      preResolve: true,
    );
    gh.lazySingleton<_i5.StudentRepository>(() => _i5.StudentRepositoryImpl(
          dio: gh<_i3.Dio>(),
          sharedPreferences: gh<_i3.SharedPreferences>(),
        ));
    gh.lazySingleton<_i6.TeacherRepository>(() => _i6.TeacherRepositoryImpl(
          dio: gh<_i3.Dio>(),
          sharedPreferences: gh<_i3.SharedPreferences>(),
        ));
    gh.lazySingleton<_i7.AuthRepository>(() => _i7.AuthRepositoryImpl(
          dio: gh<_i3.Dio>(),
          sharedPreferences: gh<_i3.SharedPreferences>(),
        ));
    gh.factory<_i8.ChangePasswordBloc>(
        () => _i8.ChangePasswordBloc(authRepository: gh<_i7.AuthRepository>()));
    gh.factory<_i9.GetStudentDetailBloc>(() => _i9.GetStudentDetailBloc(
        studentRepository: gh<_i5.StudentRepository>()));
    gh.factory<_i10.GetStudentsBloc>(() =>
        _i10.GetStudentsBloc(studentRepository: gh<_i5.StudentRepository>()));
    gh.factory<_i11.GetTeacherDetailBloc>(() => _i11.GetTeacherDetailBloc(
        teacherRepository: gh<_i6.TeacherRepository>()));
    gh.factory<_i12.GetTeachersBloc>(() =>
        _i12.GetTeachersBloc(teacherRepository: gh<_i6.TeacherRepository>()));
    gh.lazySingleton<_i13.LessonRepository>(() => _i13.LessonRepositoryImpl(
          dio: gh<_i3.Dio>(),
          sharedPreferences: gh<_i3.SharedPreferences>(),
        ));
    gh.factory<_i14.LoginBloc>(
        () => _i14.LoginBloc(authRepository: gh<_i7.AuthRepository>()));
    gh.factory<_i15.LogoutBloc>(
        () => _i15.LogoutBloc(authRepository: gh<_i7.AuthRepository>()));
    gh.lazySingleton<_i16.PaymentRepository>(() => _i16.PaymentRepositoryImpl(
          dio: gh<_i3.Dio>(),
          sharedPreferences: gh<_i3.SharedPreferences>(),
        ));
    gh.factory<_i17.SplashCubit>(
        () => _i17.SplashCubit(authRepository: gh<_i7.AuthRepository>()));
    gh.factory<_i18.GetLessonPlanDetailBloc>(() => _i18.GetLessonPlanDetailBloc(
        lessonRepository: gh<_i13.LessonRepository>()));
    gh.factory<_i19.GetLessonPlansBloc>(() =>
        _i19.GetLessonPlansBloc(lessonRepository: gh<_i13.LessonRepository>()));
    gh.factory<_i20.GetPaymentDetailBloc>(() => _i20.GetPaymentDetailBloc(
        paymentRepository: gh<_i16.PaymentRepository>()));
    gh.factory<_i21.GetPaymentsBloc>(() =>
        _i21.GetPaymentsBloc(paymentRepository: gh<_i16.PaymentRepository>()));
    return this;
  }
}

class _$CoreModule extends _i22.CoreModule {}
