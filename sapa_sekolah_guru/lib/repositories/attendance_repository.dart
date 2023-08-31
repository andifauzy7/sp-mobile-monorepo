import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:sapa_sekolah_guru/model/students_attendance_response_model.dart';
import 'package:sapa_sekolah_guru/repositories/auth_repository.dart';
import 'package:sapa_sekolah_guru/shared/core/failure/failure.dart';
import 'package:sapa_sekolah_guru/shared/core/failure/server_failure.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AttendanceRepository {
  Future<Either<Failure, List<StudentAttendanceModel>>> getStudentsAttendance(
    String lessonDate,
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
  Future<Either<Failure, List<StudentAttendanceModel>>> getStudentsAttendance(
    String lessonDate,
  ) async {
    final token = sharedPreferences.getString(keyToken);
    final userId = sharedPreferences.getString(keyUserId);
    final data = FormData.fromMap({
      "token": token,
      "user_id": userId,
      "attendance_date": lessonDate,
    });
    try {
      final response = await dio.post(
        'teacher/studentattendancedata.php',
        data: data,
      );
      if (response.statusCode == 200) {
        final result = StudentsAttendanceResponseModel.fromJson(response.data);
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
