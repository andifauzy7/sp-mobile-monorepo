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
import 'package:sapa_sekolah_wali/bloc/add_consultation/add_consultation_bloc.dart'
    as _i26;
import 'package:sapa_sekolah_wali/bloc/add_consultation_response/add_consultation_response_bloc.dart'
    as _i27;
import 'package:sapa_sekolah_wali/bloc/change_password/change_password_bloc.dart'
    as _i10;
import 'package:sapa_sekolah_wali/bloc/get_attendances/get_attendances_bloc.dart'
    as _i12;
import 'package:sapa_sekolah_wali/bloc/get_consultation_detail/get_consultation_detail_bloc.dart'
    as _i13;
import 'package:sapa_sekolah_wali/bloc/get_consultations/get_consultations_bloc.dart'
    as _i14;
import 'package:sapa_sekolah_wali/bloc/get_daily_report_detail/get_daily_report_detail_bloc.dart'
    as _i28;
import 'package:sapa_sekolah_wali/bloc/get_daily_reports/get_daily_reports_bloc.dart'
    as _i29;
import 'package:sapa_sekolah_wali/bloc/get_lesson_plan_detail/get_lesson_plan_detail_bloc.dart'
    as _i30;
import 'package:sapa_sekolah_wali/bloc/get_lesson_plans/get_lesson_plans_bloc.dart'
    as _i31;
import 'package:sapa_sekolah_wali/bloc/get_news/get_news_bloc.dart' as _i15;
import 'package:sapa_sekolah_wali/bloc/get_payment_detail/get_payment_detail_bloc.dart'
    as _i32;
import 'package:sapa_sekolah_wali/bloc/get_payments/get_payments_bloc.dart'
    as _i33;
import 'package:sapa_sekolah_wali/bloc/get_student_detail/get_student_detail_bloc.dart'
    as _i16;
import 'package:sapa_sekolah_wali/bloc/get_students/get_students_bloc.dart'
    as _i17;
import 'package:sapa_sekolah_wali/bloc/get_teacher_detail/get_teacher_detail_bloc.dart'
    as _i18;
import 'package:sapa_sekolah_wali/bloc/get_teachers/get_teachers_bloc.dart'
    as _i19;
import 'package:sapa_sekolah_wali/bloc/login/login_bloc.dart' as _i21;
import 'package:sapa_sekolah_wali/bloc/logout/logout_bloc.dart' as _i22;
import 'package:sapa_sekolah_wali/presentation/splash/cubit/splash_cubit.dart'
    as _i25;
import 'package:sapa_sekolah_wali/repositories/attendance_repository.dart'
    as _i8;
import 'package:sapa_sekolah_wali/repositories/auth_repository.dart' as _i9;
import 'package:sapa_sekolah_wali/repositories/consultation_repository.dart'
    as _i11;
import 'package:sapa_sekolah_wali/repositories/lesson_repository.dart' as _i20;
import 'package:sapa_sekolah_wali/repositories/news_repository.dart' as _i5;
import 'package:sapa_sekolah_wali/repositories/payment_repository.dart' as _i23;
import 'package:sapa_sekolah_wali/repositories/report_repository.dart' as _i24;
import 'package:sapa_sekolah_wali/repositories/student_repository.dart' as _i6;
import 'package:sapa_sekolah_wali/repositories/teacher_repository.dart' as _i7;
import 'package:sapa_sekolah_wali/shared/core/core_module.dart' as _i34;

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
    gh.lazySingleton<_i5.NewsRepository>(
        () => _i5.NewsRepositoryImpl(dio: gh<_i3.Dio>()));
    await gh.factoryAsync<_i3.SharedPreferences>(
      () => coreModule.sharedPreferences,
      preResolve: true,
    );
    gh.lazySingleton<_i6.StudentRepository>(() => _i6.StudentRepositoryImpl(
          dio: gh<_i3.Dio>(),
          sharedPreferences: gh<_i3.SharedPreferences>(),
        ));
    gh.lazySingleton<_i7.TeacherRepository>(() => _i7.TeacherRepositoryImpl(
          dio: gh<_i3.Dio>(),
          sharedPreferences: gh<_i3.SharedPreferences>(),
        ));
    gh.lazySingleton<_i8.AttendanceRepository>(
        () => _i8.AttendanceRepositoryImpl(
              dio: gh<_i3.Dio>(),
              sharedPreferences: gh<_i3.SharedPreferences>(),
            ));
    gh.lazySingleton<_i9.AuthRepository>(() => _i9.AuthRepositoryImpl(
          dio: gh<_i3.Dio>(),
          sharedPreferences: gh<_i3.SharedPreferences>(),
        ));
    gh.factory<_i10.ChangePasswordBloc>(() =>
        _i10.ChangePasswordBloc(authRepository: gh<_i9.AuthRepository>()));
    gh.lazySingleton<_i11.ConsultationRepository>(
        () => _i11.ConsultationRepositoryImpl(
              dio: gh<_i3.Dio>(),
              sharedPreferences: gh<_i3.SharedPreferences>(),
            ));
    gh.factory<_i12.GetAttendancesBloc>(() => _i12.GetAttendancesBloc(
        attendanceRepository: gh<_i8.AttendanceRepository>()));
    gh.factory<_i13.GetConsultationDetailBloc>(() =>
        _i13.GetConsultationDetailBloc(
            consultationRepository: gh<_i11.ConsultationRepository>()));
    gh.factory<_i14.GetConsultationsBloc>(() => _i14.GetConsultationsBloc(
        consultationRepository: gh<_i11.ConsultationRepository>()));
    gh.factory<_i15.GetNewsBloc>(
        () => _i15.GetNewsBloc(newsRepository: gh<_i5.NewsRepository>()));
    gh.factory<_i16.GetStudentDetailBloc>(() => _i16.GetStudentDetailBloc(
        studentRepository: gh<_i6.StudentRepository>()));
    gh.factory<_i17.GetStudentsBloc>(() =>
        _i17.GetStudentsBloc(studentRepository: gh<_i6.StudentRepository>()));
    gh.factory<_i18.GetTeacherDetailBloc>(() => _i18.GetTeacherDetailBloc(
        teacherRepository: gh<_i7.TeacherRepository>()));
    gh.factory<_i19.GetTeachersBloc>(() =>
        _i19.GetTeachersBloc(teacherRepository: gh<_i7.TeacherRepository>()));
    gh.lazySingleton<_i20.LessonRepository>(() => _i20.LessonRepositoryImpl(
          dio: gh<_i3.Dio>(),
          sharedPreferences: gh<_i3.SharedPreferences>(),
        ));
    gh.factory<_i21.LoginBloc>(
        () => _i21.LoginBloc(authRepository: gh<_i9.AuthRepository>()));
    gh.factory<_i22.LogoutBloc>(
        () => _i22.LogoutBloc(authRepository: gh<_i9.AuthRepository>()));
    gh.lazySingleton<_i23.PaymentRepository>(() => _i23.PaymentRepositoryImpl(
          dio: gh<_i3.Dio>(),
          sharedPreferences: gh<_i3.SharedPreferences>(),
        ));
    gh.lazySingleton<_i24.ReportRepository>(() => _i24.ReportRepositoryImpl(
          dio: gh<_i3.Dio>(),
          sharedPreferences: gh<_i3.SharedPreferences>(),
        ));
    gh.factory<_i25.SplashCubit>(
        () => _i25.SplashCubit(authRepository: gh<_i9.AuthRepository>()));
    gh.factory<_i26.AddConsultationBloc>(() => _i26.AddConsultationBloc(
        consultationRepository: gh<_i11.ConsultationRepository>()));
    gh.factory<_i27.AddConsultationResponseBloc>(() =>
        _i27.AddConsultationResponseBloc(
            consultationRepository: gh<_i11.ConsultationRepository>()));
    gh.factory<_i28.GetDailyReportDetailBloc>(() =>
        _i28.GetDailyReportDetailBloc(
            reportRepository: gh<_i24.ReportRepository>()));
    gh.factory<_i29.GetDailyReportsBloc>(() => _i29.GetDailyReportsBloc(
        reportRepository: gh<_i24.ReportRepository>()));
    gh.factory<_i30.GetLessonPlanDetailBloc>(() => _i30.GetLessonPlanDetailBloc(
        lessonRepository: gh<_i20.LessonRepository>()));
    gh.factory<_i31.GetLessonPlansBloc>(() =>
        _i31.GetLessonPlansBloc(lessonRepository: gh<_i20.LessonRepository>()));
    gh.factory<_i32.GetPaymentDetailBloc>(() => _i32.GetPaymentDetailBloc(
        paymentRepository: gh<_i23.PaymentRepository>()));
    gh.factory<_i33.GetPaymentsBloc>(() =>
        _i33.GetPaymentsBloc(paymentRepository: gh<_i23.PaymentRepository>()));
    return this;
  }
}

class _$CoreModule extends _i34.CoreModule {}
