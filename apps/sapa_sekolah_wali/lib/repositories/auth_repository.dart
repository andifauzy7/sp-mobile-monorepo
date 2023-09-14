import 'package:sapa_core/failure/failure.dart';
import 'package:sapa_core/failure/server_failure.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_wali/model/login_response_model.dart';

const String keyToken = "CACHE_KEY_TOKEN";
const String keyUserId = "CACHE_USER_ID";

abstract class AuthRepositoryTemp {
  Future<Either<Failure, bool>> isTokenExist();
  Future<Either<Failure, bool>> login(String username, String password);
}

@LazySingleton(as: AuthRepositoryTemp)
class AuthRepositoryTempImpl implements AuthRepositoryTemp {
  final Dio dio;
  final SharedPreferences sharedPreferences;

  AuthRepositoryTempImpl({
    required this.dio,
    required this.sharedPreferences,
  });

  @override
  Future<Either<Failure, bool>> isTokenExist() async {
    final token = sharedPreferences.getString(keyToken);
    return Right(token?.isNotEmpty ?? false);
  }

  @override
  Future<Either<Failure, bool>> login(String username, String password) async {
    final data = FormData.fromMap({
      "username": username,
      "password": password,
    });
    try {
      final response = await dio.post(
        'login.php',
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
}
