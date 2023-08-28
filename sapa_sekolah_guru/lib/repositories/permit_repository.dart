import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:sapa_sekolah_guru/model/add_permit_response_model.dart';
import 'package:sapa_sekolah_guru/model/permit_type_response_model.dart';
import 'package:sapa_sekolah_guru/model/student_permits_response_model.dart';
import 'package:sapa_sekolah_guru/repositories/auth_repository.dart';
import 'package:sapa_sekolah_guru/shared/core/failure/failure.dart';
import 'package:sapa_sekolah_guru/shared/core/failure/server_failure.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PermitRepository {
  Future<Either<Failure, List<StudentPermitModel>>> getStudentPermits();
  Future<Either<Failure, List<PermitTypeModel>>> getPermitType();
  Future<Either<Failure, bool>> addPermit(
    String studentId,
    String permitType,
    String dateStart,
    String dateEnd,
    String notes,
  );
}

@LazySingleton(as: PermitRepository)
class PermitRepositoryImpl implements PermitRepository {
  final Dio dio;
  final SharedPreferences sharedPreferences;

  PermitRepositoryImpl({
    required this.dio,
    required this.sharedPreferences,
  });

  @override
  Future<Either<Failure, List<StudentPermitModel>>> getStudentPermits() async {
    final token = sharedPreferences.getString(keyToken);
    final userId = sharedPreferences.getString(keyUserId);
    final data = FormData.fromMap({
      "token": token,
      "user_id": userId,
    });
    try {
      final response = await dio.post(
        'teacher/studentpermit.php',
        data: data,
      );
      if (response.statusCode == 200) {
        final result = StudentPermitsResponseModel.fromJson(response.data);
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
  Future<Either<Failure, List<PermitTypeModel>>> getPermitType() async {
    final token = sharedPreferences.getString(keyToken);
    final userId = sharedPreferences.getString(keyUserId);
    final data = FormData.fromMap({
      "token": token,
      "user_id": userId,
    });
    try {
      final response = await dio.post(
        'teacher/permittype.php',
        data: data,
      );
      if (response.statusCode == 200) {
        final result = PermitTypeResponseModel.fromJson(response.data);
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
  Future<Either<Failure, bool>> addPermit(
    String studentId,
    String permitType,
    String dateStart,
    String dateEnd,
    String notes,
  ) async {
    final token = sharedPreferences.getString(keyToken);
    final userId = sharedPreferences.getString(keyUserId);
    final data = FormData.fromMap({
      "token": token,
      "user_id": userId,
      "student_id": studentId,
      "permit_type": permitType,
      "date_start": dateStart,
      "date_end": dateEnd,
      "notes": notes,
    });
    try {
      final response = await dio.post(
        'teacher/studentpermitadd.php',
        data: data,
      );
      if (response.statusCode == 200) {
        final result = AddPermitResponseModel.fromJson(response.data);
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
