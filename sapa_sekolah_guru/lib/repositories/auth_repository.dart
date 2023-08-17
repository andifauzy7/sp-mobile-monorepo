import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:sapa_sekolah_guru/model/login_response_model.dart';
import 'package:sapa_sekolah_guru/shared/core/failure/failure.dart';
import 'package:sapa_sekolah_guru/shared/core/failure/server_failure.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String keyToken = "CACHE_KEY_TOKEN";
const String keyUserId = "CACHE_USER_ID";

abstract class AuthRepository {
  Future<Either<Failure, bool>> login(String username, String password);
  Future<Either<Failure, bool>> isTokenExist();
  Future<Either<Failure, bool>> logout();
}

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final Dio dio;
  final SharedPreferences sharedPreferences;

  AuthRepositoryImpl({
    required this.dio,
    required this.sharedPreferences,
  });

  @override
  Future<Either<Failure, bool>> login(String username, String password) async {
    final data = FormData.fromMap({
      "username": username,
      "password": password,
    });
    try {
      final response = await dio.post(
        'teacher/login.php',
        data: data,
      );
      if (response.statusCode == 200) {
        final result = LoginResponseModel.fromJson(response.data);
        await sharedPreferences.setString(
          keyToken,
          result.data?.token ?? '',
        );
        await sharedPreferences.setString(
          keyUserId,
          result.data?.userId ?? '',
        );
        if (result.success ?? false) {
          return const Right(true);
        } else {
          return Left(
            ServerFailure(message: result.message),
          );
        }
      } else {
        return Left(
          ServerFailure(message: response.data['message']),
        );
      }
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isTokenExist() async {
    final token = sharedPreferences.getString(keyToken);
    return Right(token?.isNotEmpty ?? false);
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    return Right(await sharedPreferences.clear());
  }
}
