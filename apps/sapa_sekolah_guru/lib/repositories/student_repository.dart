import 'package:sapa_core/failure/failure.dart';
import 'package:sapa_core/failure/server_failure.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_guru/model/students_response_model.dart';
import 'package:sapa_sekolah_guru/repositories/auth_repository.dart';

abstract class StudentRepository {
  Future<Either<Failure, List<StudentModel>>> getStudents();
}

@LazySingleton(as: StudentRepository)
class StudentRepositoryImpl implements StudentRepository {
  final Dio dio;
  final SharedPreferences sharedPreferences;

  StudentRepositoryImpl({
    required this.dio,
    required this.sharedPreferences,
  });
  @override
  Future<Either<Failure, List<StudentModel>>> getStudents() async {
    final token = sharedPreferences.getString(keyToken);
    final userId = sharedPreferences.getString(keyUserId);
    final data = FormData.fromMap({
      "token": token,
      "user_id": userId,
    });
    try {
      final response = await dio.post(
        'getstudentlist.php',
        data: data,
      );
      if (response.statusCode == 200) {
        final result = StudentsResponseModel.fromJson(response.data);
        if (result.success ?? false) {
          return Right(result.data ?? []);
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
