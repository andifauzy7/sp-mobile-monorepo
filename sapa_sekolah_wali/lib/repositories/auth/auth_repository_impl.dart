import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:injectable/injectable.dart';
import 'package:sapa_sekolah_wali/model/auth/login_model.dart';
import 'package:sapa_sekolah_wali/model/base_model.dart';
import 'package:sapa_sekolah_wali/model/exception_model.dart';
import 'package:sapa_sekolah_wali/repositories/auth/auth_repository.dart';
import 'package:sapa_sekolah_wali/repositories/utils/api_path.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final Dio dio;
  final esp = EncryptedSharedPreferences();

  AuthRepositoryImpl(this.dio);

  @override
  Future<Either<ExceptionModel, BaseModel>> login(
      String username, String password) async {
    final sp = await esp.getInstance();

    final formData = FormData.fromMap({
      "username": username,
      "password": password,
    });

    try {
      final response = await dio.post(ApiPath.LOGIN, data: formData);
      if (response.data['success']) {
        final result = LoginModel.fromJson(response.data['data']);
        sp.setString('token', result.token!);
        sp.setString('user_id', result.userId!.toString());
        return Right(result);
      } else {
        return Left(ExceptionModel(response.data['message']));
      }
    } catch (e) {
      return Left(ExceptionModel(e.toString()));
    }
  }

  @override
  Future<Either<ExceptionModel, BaseModel>> changePassword(
      Map<String, dynamic> payload) async {
    final formData = FormData.fromMap(payload);

    try {
      await dio.post(ApiPath.CHANGE_PASSWORD, data: formData);
      return Right(BaseModel());
    } catch (e) {
      return Left(ExceptionModel(e.toString()));
    }
  }
}
