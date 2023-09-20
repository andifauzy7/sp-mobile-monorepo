import 'package:sapa_core/failure/failure.dart';
import 'package:sapa_core/failure/server_failure.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_wali/model/attendances_response_model.dart';
import 'package:sapa_sekolah_wali/repositories/auth_repository.dart';

abstract class AttendanceRepository {
  Future<Either<Failure, List<AttendanceModel>>> getAttendances(
    String studentId,
    String month,
    String year,
  );
}

@LazySingleton(as: AttendanceRepository)
class AttendanceRepositoryImpl implements AttendanceRepository {
  final Dio dio;
  final SharedPreferences sharedPreferences;

  AttendanceRepositoryImpl({
    required this.dio,
    required this.sharedPreferences,
  });

  @override
  Future<Either<Failure, List<AttendanceModel>>> getAttendances(
    String studentId,
    String month,
    String year,
  ) async {
    final token = sharedPreferences.getString(keyToken);
    final userId = sharedPreferences.getString(keyUserId);
    final data = FormData.fromMap({
      "token": token,
      "user_id": userId,
      "student_id": studentId,
      "month": month,
      "year": year,
    });
    try {
      final response = await dio.post(
        'studentattendance.php',
        data: data,
      );
      if (response.statusCode == 200) {
        final result = AttendancesResponseModel.fromJson(response.data);
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
