// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:sapa_sekolah_wali/application/bloc/auth/auth_bloc.dart' as _i22;
import 'package:sapa_sekolah_wali/application/bloc/change_password/change_password_cubit.dart'
    as _i13;
import 'package:sapa_sekolah_wali/application/bloc/child/child_bloc.dart'
    as _i23;
import 'package:sapa_sekolah_wali/application/bloc/detail_child/detail_child_bloc.dart'
    as _i16;
import 'package:sapa_sekolah_wali/application/bloc/detail_payment/detail_payment_bloc.dart'
    as _i24;
import 'package:sapa_sekolah_wali/application/bloc/list_payment/list_payment_bloc.dart'
    as _i19;
import 'package:sapa_sekolah_wali/application/bloc/news/news_bloc.dart' as _i20;
import 'package:sapa_sekolah_wali/application/bloc/teacher/teacher_bloc.dart'
    as _i21;
import 'package:sapa_sekolah_wali/repositories/auth/auth_repository.dart'
    as _i11;
import 'package:sapa_sekolah_wali/repositories/auth/auth_repository_impl.dart'
    as _i12;
import 'package:sapa_sekolah_wali/repositories/auth/session_repository.dart'
    as _i8;
import 'package:sapa_sekolah_wali/repositories/child/child_repository.dart'
    as _i14;
import 'package:sapa_sekolah_wali/repositories/child/child_repository_impl.dart'
    as _i15;
import 'package:sapa_sekolah_wali/repositories/news/new_repository_impl.dart'
    as _i7;
import 'package:sapa_sekolah_wali/repositories/news/news_repository.dart'
    as _i6;
import 'package:sapa_sekolah_wali/repositories/payment/detail_payment_repository.dart'
    as _i17;
import 'package:sapa_sekolah_wali/repositories/payment/detail_payment_repository_impl.dart'
    as _i18;
import 'package:sapa_sekolah_wali/repositories/payment/list_payment_repository.dart'
    as _i4;
import 'package:sapa_sekolah_wali/repositories/payment/list_payment_repository_impl.dart'
    as _i5;
import 'package:sapa_sekolah_wali/repositories/teacher/teacher_repository.dart'
    as _i9;
import 'package:sapa_sekolah_wali/repositories/teacher/teacher_repository_impl.dart'
    as _i10;
import 'package:sapa_sekolah_wali/repositories/utils/api_utils.dart' as _i25;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final apiUtils = _$ApiUtils();
    gh.lazySingleton<_i3.Dio>(() => apiUtils.dio());
    gh.lazySingleton<_i4.ListPaymentRepository>(
        () => _i5.ListPaymentRepositoryImpl(gh<_i3.Dio>()));
    gh.lazySingleton<_i6.NewsRepository>(
        () => _i7.NewsRepositoryImpl(gh<_i3.Dio>()));
    gh.factory<_i8.SessionRepository>(() => _i8.SessionRepository());
    gh.lazySingleton<_i9.TeacherRepository>(
        () => _i10.TeacherRepositoryImpl(gh<_i3.Dio>()));
    gh.lazySingleton<_i11.AuthRepository>(
        () => _i12.AuthRepositoryImpl(gh<_i3.Dio>()));
    gh.factory<_i13.ChangePasswordCubit>(
        () => _i13.ChangePasswordCubit(gh<_i11.AuthRepository>()));
    gh.lazySingleton<_i14.ChildRepository>(
        () => _i15.ChildRepositoryImpl(gh<_i3.Dio>()));
    gh.factory<_i16.DetailChildBloc>(
        () => _i16.DetailChildBloc(gh<_i14.ChildRepository>()));
    gh.lazySingleton<_i17.DetailPaymentRepository>(
        () => _i18.DetailPaymentRepositoryImpl(gh<_i3.Dio>()));
    gh.factory<_i19.ListPaymentBloc>(
        () => _i19.ListPaymentBloc(gh<_i4.ListPaymentRepository>()));
    gh.factory<_i20.NewsBloc>(() => _i20.NewsBloc(gh<_i6.NewsRepository>()));
    gh.factory<_i21.TeacherBloc>(
        () => _i21.TeacherBloc(gh<_i9.TeacherRepository>()));
    gh.factory<_i22.AuthBloc>(() => _i22.AuthBloc(gh<_i11.AuthRepository>()));
    gh.factory<_i23.ChildBloc>(
        () => _i23.ChildBloc(gh<_i14.ChildRepository>()));
    gh.factory<_i24.DetailPaymentBloc>(
        () => _i24.DetailPaymentBloc(gh<_i17.DetailPaymentRepository>()));
    return this;
  }
}

class _$ApiUtils extends _i25.ApiUtils {}
