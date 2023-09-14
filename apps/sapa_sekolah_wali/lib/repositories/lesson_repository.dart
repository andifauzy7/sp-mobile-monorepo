import 'package:sapa_core/failure/failure.dart';
import 'package:sapa_core/failure/server_failure.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_wali/model/lesson_plan_detail_response_model.dart';
import 'package:sapa_sekolah_wali/model/lesson_plans_response_model.dart';
import 'package:sapa_sekolah_wali/repositories/auth_repository.dart';

abstract class LessonRepository {
  Future<Either<Failure, LessonPlanDetailModel>> getLessonPlanDetail(String id);
  Future<Either<Failure, List<LessonPlanModel>>> getLessonPlans(
    String studentId,
  );
}

@LazySingleton(as: LessonRepository)
class LessonRepositoryImpl implements LessonRepository {
  final Dio dio;
  final SharedPreferences sharedPreferences;

  LessonRepositoryImpl({
    required this.dio,
    required this.sharedPreferences,
  });

  @override
  Future<Either<Failure, List<LessonPlanModel>>> getLessonPlans(
    String studentId,
  ) async {
    final token = sharedPreferences.getString(keyToken);
    final userId = sharedPreferences.getString(keyUserId);
    final data = FormData.fromMap({
      "token": token,
      "user_id": userId,
      "student_id": studentId,
    });
    try {
      final response = await dio.post(
        'lessonplanlist.php',
        data: data,
      );
      if (response.statusCode == 200) {
        final result = LessonPlansResponseModel.fromJson(response.data);
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
  Future<Either<Failure, LessonPlanDetailModel>> getLessonPlanDetail(
      String id) async {
    final token = sharedPreferences.getString(keyToken);
    final userId = sharedPreferences.getString(keyUserId);
    final data = FormData.fromMap({
      "token": token,
      "user_id": userId,
      "lessonplan_id": id,
    });
    try {
      final response = await dio.post(
        'lessonplandetail.php',
        data: data,
      );
      if (response.statusCode == 200) {
        final result = LessonPlanDetailResponseModel.fromJson(response.data);
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
