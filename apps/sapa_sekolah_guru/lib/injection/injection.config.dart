// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:sapa_core/sapa_core.dart' as _i3;
import 'package:sapa_sekolah_guru/bloc/add_activity/add_activity_bloc.dart'
    as _i23;
import 'package:sapa_sekolah_guru/bloc/add_consultation_response/add_consultation_response_bloc.dart'
    as _i24;
import 'package:sapa_sekolah_guru/bloc/add_lesson/add_lesson_bloc.dart' as _i25;
import 'package:sapa_sekolah_guru/bloc/add_lesson_plan/add_lesson_plan_bloc.dart'
    as _i26;
import 'package:sapa_sekolah_guru/bloc/add_permit/add_permit_bloc.dart' as _i27;
import 'package:sapa_sekolah_guru/bloc/change_password/change_password_bloc.dart'
    as _i8;
import 'package:sapa_sekolah_guru/bloc/delete_lesson_plan/delete_lesson_plan_bloc.dart'
    as _i28;
import 'package:sapa_sekolah_guru/bloc/get_activities/get_activities_bloc.dart'
    as _i29;
import 'package:sapa_sekolah_guru/bloc/get_consultation_detail/get_consultation_detail_bloc.dart'
    as _i10;
import 'package:sapa_sekolah_guru/bloc/get_consultations/get_consultations_bloc.dart'
    as _i11;
import 'package:sapa_sekolah_guru/bloc/get_daily_report_detail/get_daily_report_detail_bloc.dart'
    as _i30;
import 'package:sapa_sekolah_guru/bloc/get_daily_reports/get_daily_reports_bloc.dart'
    as _i31;
import 'package:sapa_sekolah_guru/bloc/get_lesson_plan_detail/get_lesson_plan_detail_bloc.dart'
    as _i32;
import 'package:sapa_sekolah_guru/bloc/get_lesson_plans/get_lesson_plans_bloc.dart'
    as _i33;
import 'package:sapa_sekolah_guru/bloc/get_lessons/get_lessons_bloc.dart'
    as _i34;
import 'package:sapa_sekolah_guru/bloc/get_permit_type/get_permit_type_bloc.dart'
    as _i35;
import 'package:sapa_sekolah_guru/bloc/get_student_permits/get_student_permits_bloc.dart'
    as _i36;
import 'package:sapa_sekolah_guru/bloc/get_students/get_students_bloc.dart'
    as _i13;
import 'package:sapa_sekolah_guru/bloc/get_students_attendance/get_students_attendance_bloc.dart'
    as _i12;
import 'package:sapa_sekolah_guru/bloc/get_teacher/get_teacher_bloc.dart'
    as _i14;
import 'package:sapa_sekolah_guru/bloc/login/login_bloc.dart' as _i16;
import 'package:sapa_sekolah_guru/bloc/logout/logout_bloc.dart' as _i17;
import 'package:sapa_sekolah_guru/bloc/submit_student_attendance/submit_student_attendance_bloc.dart'
    as _i21;
import 'package:sapa_sekolah_guru/bloc/update_daily_report/update_daily_report_bloc.dart'
    as _i22;
import 'package:sapa_sekolah_guru/presentation/splash/cubit/splash_cubit.dart'
    as _i20;
import 'package:sapa_sekolah_guru/repositories/attendance_repository.dart'
    as _i6;
import 'package:sapa_sekolah_guru/repositories/auth_repository.dart' as _i7;
import 'package:sapa_sekolah_guru/repositories/consultation_repository.dart'
    as _i9;
import 'package:sapa_sekolah_guru/repositories/lesson_repository.dart' as _i15;
import 'package:sapa_sekolah_guru/repositories/permit_repository.dart' as _i18;
import 'package:sapa_sekolah_guru/repositories/report_repository.dart' as _i19;
import 'package:sapa_sekolah_guru/repositories/student_repository.dart' as _i5;
import 'package:sapa_sekolah_guru/shared/core/core_module.dart' as _i37;

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
    gh.lazySingleton<_i6.AttendanceRepository>(
        () => _i6.AttendanceRepositoryImpl(
              dio: gh<_i3.Dio>(),
              sharedPreferences: gh<_i3.SharedPreferences>(),
            ));
    gh.lazySingleton<_i7.AuthRepository>(() => _i7.AuthRepositoryImpl(
          dio: gh<_i3.Dio>(),
          sharedPreferences: gh<_i3.SharedPreferences>(),
        ));
    gh.factory<_i8.ChangePasswordBloc>(
        () => _i8.ChangePasswordBloc(authRepository: gh<_i7.AuthRepository>()));
    gh.lazySingleton<_i9.ConsultationRepository>(
        () => _i9.ConsultationRepositoryImpl(
              dio: gh<_i3.Dio>(),
              sharedPreferences: gh<_i3.SharedPreferences>(),
            ));
    gh.factory<_i10.GetConsultationDetailBloc>(() =>
        _i10.GetConsultationDetailBloc(
            consultationRepository: gh<_i9.ConsultationRepository>()));
    gh.factory<_i11.GetConsultationsBloc>(() => _i11.GetConsultationsBloc(
        consultationRepository: gh<_i9.ConsultationRepository>()));
    gh.factory<_i12.GetStudentsAttendanceBloc>(() =>
        _i12.GetStudentsAttendanceBloc(
            attendanceRepository: gh<_i6.AttendanceRepository>()));
    gh.factory<_i13.GetStudentsBloc>(() =>
        _i13.GetStudentsBloc(studentRepository: gh<_i5.StudentRepository>()));
    gh.factory<_i14.GetTeacherBloc>(
        () => _i14.GetTeacherBloc(authRepository: gh<_i7.AuthRepository>()));
    gh.lazySingleton<_i15.LessonRepository>(() => _i15.LessonRepositoryImpl(
          dio: gh<_i3.Dio>(),
          sharedPreferences: gh<_i3.SharedPreferences>(),
        ));
    gh.factory<_i16.LoginBloc>(
        () => _i16.LoginBloc(authRepository: gh<_i7.AuthRepository>()));
    gh.factory<_i17.LogoutBloc>(
        () => _i17.LogoutBloc(authRepository: gh<_i7.AuthRepository>()));
    gh.lazySingleton<_i18.PermitRepository>(() => _i18.PermitRepositoryImpl(
          dio: gh<_i3.Dio>(),
          sharedPreferences: gh<_i3.SharedPreferences>(),
        ));
    gh.lazySingleton<_i19.ReportRepository>(() => _i19.ReportRepositoryImpl(
          dio: gh<_i3.Dio>(),
          sharedPreferences: gh<_i3.SharedPreferences>(),
        ));
    gh.factory<_i20.SplashCubit>(
        () => _i20.SplashCubit(authRepository: gh<_i7.AuthRepository>()));
    gh.factory<_i21.SubmitStudentAttendanceBloc>(() =>
        _i21.SubmitStudentAttendanceBloc(
            attendanceRepository: gh<_i6.AttendanceRepository>()));
    gh.factory<_i22.UpdateDailyReportBloc>(() => _i22.UpdateDailyReportBloc(
        reportRepository: gh<_i19.ReportRepository>()));
    gh.factory<_i23.AddActivityBloc>(() =>
        _i23.AddActivityBloc(lessonRepository: gh<_i15.LessonRepository>()));
    gh.factory<_i24.AddConsultationResponseBloc>(() =>
        _i24.AddConsultationResponseBloc(
            consultationRepository: gh<_i9.ConsultationRepository>()));
    gh.factory<_i25.AddLessonBloc>(() =>
        _i25.AddLessonBloc(lessonRepository: gh<_i15.LessonRepository>()));
    gh.factory<_i26.AddLessonPlanBloc>(() =>
        _i26.AddLessonPlanBloc(lessonRepository: gh<_i15.LessonRepository>()));
    gh.factory<_i27.AddPermitBloc>(() =>
        _i27.AddPermitBloc(permitRepository: gh<_i18.PermitRepository>()));
    gh.factory<_i28.DeleteLessonPlanBloc>(() => _i28.DeleteLessonPlanBloc(
        lessonRepository: gh<_i15.LessonRepository>()));
    gh.factory<_i29.GetActivitiesBloc>(() =>
        _i29.GetActivitiesBloc(lessonRepository: gh<_i15.LessonRepository>()));
    gh.factory<_i30.GetDailyReportDetailBloc>(() =>
        _i30.GetDailyReportDetailBloc(
            reportRepository: gh<_i19.ReportRepository>()));
    gh.factory<_i31.GetDailyReportsBloc>(() => _i31.GetDailyReportsBloc(
        reportRepository: gh<_i19.ReportRepository>()));
    gh.factory<_i32.GetLessonPlanDetailBloc>(() => _i32.GetLessonPlanDetailBloc(
        lessonRepository: gh<_i15.LessonRepository>()));
    gh.factory<_i33.GetLessonPlansBloc>(() =>
        _i33.GetLessonPlansBloc(lessonRepository: gh<_i15.LessonRepository>()));
    gh.factory<_i34.GetLessonsBloc>(() =>
        _i34.GetLessonsBloc(lessonRepository: gh<_i15.LessonRepository>()));
    gh.factory<_i35.GetPermitTypeBloc>(() =>
        _i35.GetPermitTypeBloc(permitRepository: gh<_i18.PermitRepository>()));
    gh.factory<_i36.GetStudentPermitsBloc>(() => _i36.GetStudentPermitsBloc(
        permitRepository: gh<_i18.PermitRepository>()));
    return this;
  }
}

class _$CoreModule extends _i37.CoreModule {}
