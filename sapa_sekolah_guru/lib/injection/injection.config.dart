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
    as _i20;
import 'package:sapa_sekolah_guru/bloc/add_lesson/add_lesson_bloc.dart' as _i21;
import 'package:sapa_sekolah_guru/bloc/add_lesson_plan/add_lesson_plan_bloc.dart'
    as _i22;
import 'package:sapa_sekolah_guru/bloc/add_permit/add_permit_bloc.dart' as _i23;
import 'package:sapa_sekolah_guru/bloc/change_password/change_password_bloc.dart'
    as _i10;
import 'package:sapa_sekolah_guru/bloc/delete_lesson_plan/delete_lesson_plan_bloc.dart'
    as _i24;
import 'package:sapa_sekolah_guru/bloc/get_activities/get_activities_bloc.dart'
    as _i25;
import 'package:sapa_sekolah_guru/bloc/get_lesson_plan_detail/get_lesson_plan_detail_bloc.dart'
    as _i26;
import 'package:sapa_sekolah_guru/bloc/get_lesson_plans/get_lesson_plans_bloc.dart'
    as _i27;
import 'package:sapa_sekolah_guru/bloc/get_lessons/get_lessons_bloc.dart'
    as _i28;
import 'package:sapa_sekolah_guru/bloc/get_permit_type/get_permit_type_bloc.dart'
    as _i29;
import 'package:sapa_sekolah_guru/bloc/get_student_permits/get_student_permits_bloc.dart'
    as _i30;
import 'package:sapa_sekolah_guru/bloc/get_students/get_students_bloc.dart'
    as _i12;
import 'package:sapa_sekolah_guru/bloc/get_students_attendance/get_students_attendance_bloc.dart'
    as _i11;
import 'package:sapa_sekolah_guru/bloc/get_teacher/get_teacher_bloc.dart'
    as _i13;
import 'package:sapa_sekolah_guru/bloc/login/login_bloc.dart' as _i15;
import 'package:sapa_sekolah_guru/bloc/logout/logout_bloc.dart' as _i16;
import 'package:sapa_sekolah_guru/bloc/submit_student_attendance/submit_student_attendance_bloc.dart'
    as _i19;
import 'package:sapa_sekolah_guru/presentation/splash/cubit/splash_cubit.dart'
    as _i18;
import 'package:sapa_sekolah_guru/repositories/attendance_repository.dart'
    as _i8;
import 'package:sapa_sekolah_guru/repositories/auth_repository.dart' as _i9;
import 'package:sapa_sekolah_guru/repositories/lesson_repository.dart' as _i14;
import 'package:sapa_sekolah_guru/repositories/permit_repository.dart' as _i17;
import 'package:sapa_sekolah_guru/repositories/student_repository.dart' as _i7;
import 'package:sapa_sekolah_guru/shared/core/core_module.dart' as _i31;
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
    gh.lazySingleton<_i7.StudentRepository>(() => _i7.StudentRepositoryImpl(
          dio: gh<_i4.Dio>(),
          sharedPreferences: gh<_i6.SharedPreferences>(),
        ));
    gh.lazySingleton<_i8.AttendanceRepository>(
        () => _i8.AttendanceRepositoryImpl(
              dio: gh<_i4.Dio>(),
              sharedPreferences: gh<_i6.SharedPreferences>(),
            ));
    gh.lazySingleton<_i9.AuthRepository>(() => _i9.AuthRepositoryImpl(
          dio: gh<_i4.Dio>(),
          sharedPreferences: gh<_i6.SharedPreferences>(),
        ));
    gh.factory<_i10.ChangePasswordBloc>(() =>
        _i10.ChangePasswordBloc(authRepository: gh<_i9.AuthRepository>()));
    gh.factory<_i11.GetStudentsAttendanceBloc>(() =>
        _i11.GetStudentsAttendanceBloc(
            attendanceRepository: gh<_i8.AttendanceRepository>()));
    gh.factory<_i12.GetStudentsBloc>(() =>
        _i12.GetStudentsBloc(studentRepository: gh<_i7.StudentRepository>()));
    gh.factory<_i13.GetTeacherBloc>(
        () => _i13.GetTeacherBloc(authRepository: gh<_i9.AuthRepository>()));
    gh.lazySingleton<_i14.LessonRepository>(() => _i14.LessonRepositoryImpl(
          dio: gh<_i4.Dio>(),
          sharedPreferences: gh<_i6.SharedPreferences>(),
        ));
    gh.factory<_i15.LoginBloc>(
        () => _i15.LoginBloc(authRepository: gh<_i9.AuthRepository>()));
    gh.factory<_i16.LogoutBloc>(
        () => _i16.LogoutBloc(authRepository: gh<_i9.AuthRepository>()));
    gh.lazySingleton<_i17.PermitRepository>(() => _i17.PermitRepositoryImpl(
          dio: gh<_i4.Dio>(),
          sharedPreferences: gh<_i6.SharedPreferences>(),
        ));
    gh.factory<_i18.SplashCubit>(
        () => _i18.SplashCubit(authRepository: gh<_i9.AuthRepository>()));
    gh.factory<_i19.SubmitStudentAttendanceBloc>(() =>
        _i19.SubmitStudentAttendanceBloc(
            attendanceRepository: gh<_i8.AttendanceRepository>()));
    gh.factory<_i20.AddActivityBloc>(() =>
        _i20.AddActivityBloc(lessonRepository: gh<_i14.LessonRepository>()));
    gh.factory<_i21.AddLessonBloc>(() =>
        _i21.AddLessonBloc(lessonRepository: gh<_i14.LessonRepository>()));
    gh.factory<_i22.AddLessonPlanBloc>(() =>
        _i22.AddLessonPlanBloc(lessonRepository: gh<_i14.LessonRepository>()));
    gh.factory<_i23.AddPermitBloc>(() =>
        _i23.AddPermitBloc(permitRepository: gh<_i17.PermitRepository>()));
    gh.factory<_i24.DeleteLessonPlanBloc>(() => _i24.DeleteLessonPlanBloc(
        lessonRepository: gh<_i14.LessonRepository>()));
    gh.factory<_i25.GetActivitiesBloc>(() =>
        _i25.GetActivitiesBloc(lessonRepository: gh<_i14.LessonRepository>()));
    gh.factory<_i26.GetLessonPlanDetailBloc>(() => _i26.GetLessonPlanDetailBloc(
        lessonRepository: gh<_i14.LessonRepository>()));
    gh.factory<_i27.GetLessonPlansBloc>(() =>
        _i27.GetLessonPlansBloc(lessonRepository: gh<_i14.LessonRepository>()));
    gh.factory<_i28.GetLessonsBloc>(() =>
        _i28.GetLessonsBloc(lessonRepository: gh<_i14.LessonRepository>()));
    gh.factory<_i29.GetPermitTypeBloc>(() =>
        _i29.GetPermitTypeBloc(permitRepository: gh<_i17.PermitRepository>()));
    gh.factory<_i30.GetStudentPermitsBloc>(() => _i30.GetStudentPermitsBloc(
        permitRepository: gh<_i17.PermitRepository>()));
    return this;
  }
}

class _$CoreModule extends _i31.CoreModule {}
