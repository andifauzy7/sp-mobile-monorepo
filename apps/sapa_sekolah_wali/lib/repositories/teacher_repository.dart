import 'package:sapa_core/failure/failure.dart';
import 'package:sapa_core/failure/server_failure.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_wali/model/teacher_detail_response_model.dart';
import 'package:sapa_sekolah_wali/model/teachers_response_model.dart';
import 'package:sapa_sekolah_wali/repositories/auth_repository.dart';

abstract class TeacherRepository {
  Future<Either<Failure, List<TeacherModel>>> getTeachers();
  Future<Either<Failure, TeacherDetailModel>> getDetailTeacher(
      String teacherId);
}

@LazySingleton(as: TeacherRepository)
class TeacherRepositoryImpl implements TeacherRepository {
  final Dio dio;
  final SharedPreferences sharedPreferences;

  TeacherRepositoryImpl({
    required this.dio,
    required this.sharedPreferences,
  });
  @override
  Future<Either<Failure, List<TeacherModel>>> getTeachers() async {
    final token = sharedPreferences.getString(keyToken);
    final userId = sharedPreferences.getString(keyUserId);
    final data = FormData.fromMap({
      "token": token,
      "user_id": userId,
    });
    try {
      final response = await dio.post(
        'teacherlist.php',
        data: data,
      );
      if (response.statusCode == 200) {
        final result = TeachersResponseModel.fromJson(response.data);
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

  @override
  Future<Either<Failure, TeacherDetailModel>> getDetailTeacher(
    String teacherId,
  ) async {
    final token = sharedPreferences.getString(keyToken);
    final userId = sharedPreferences.getString(keyUserId);
    final data = FormData.fromMap({
      "token": token,
      "user_id": userId,
      "employee_id": teacherId,
    });
    try {
      final response = await dio.post(
        'teacherdetail.php',
        data: data,
      );
      if (response.statusCode == 200) {
        final result = TeacherDetailResponseModel.fromJson(response.data);
        if (result.success ?? false) {
          return Right(result.data!);
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
