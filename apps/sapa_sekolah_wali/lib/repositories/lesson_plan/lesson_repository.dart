import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:injectable/injectable.dart';
import 'package:sapa_sekolah_wali/model/exception_model.dart';
import 'package:sapa_sekolah_wali/model/lesson_plan/lesson_plan_detail_response_model.dart';
import 'package:sapa_sekolah_wali/model/lesson_plan/lesson_plans_response_model.dart';
import 'package:sapa_sekolah_wali/repositories/utils/api_path.dart';

abstract class LessonRepository {
  Future<Either<ExceptionModel, List<LessonPlanModel>>> getLessonPlans(
    String studentId,
  );
  Future<Either<ExceptionModel, LessonPlanDetailModel>> getLessonPlanDetail(
    String id,
  );
}

@LazySingleton(as: LessonRepository)
class LessonRepositoryImpl implements LessonRepository {
  Dio dio;
  final esp = EncryptedSharedPreferences();

  LessonRepositoryImpl({
    required this.dio,
  });

  @override
  Future<Either<ExceptionModel, List<LessonPlanModel>>> getLessonPlans(
    String studentId,
  ) async {
    final sp = await esp.getInstance();
    final token = sp.getString('token');
    final userId = sp.getString('user_id');

    final formData = FormData.fromMap({
      "token": token,
      "user_id": userId,
      "student_id": studentId,
    });

    try {
      final response = await dio.post(ApiPath.LESSON_PLAN_LIST, data: formData);
      final result = LessonPlansResponseModel.fromJson(response.data);
      return Right(result.data ?? []);
    } catch (e) {
      return Left(ExceptionModel(e.toString()));
    }
  }

  @override
  Future<Either<ExceptionModel, LessonPlanDetailModel>> getLessonPlanDetail(
      String id) async {
    final sp = await esp.getInstance();
    final token = sp.getString('token');
    final userId = sp.getString('user_id');
    final formData = FormData.fromMap({
      "token": token,
      "user_id": userId,
      "lessonplan_id": id,
    });
    try {
      final response = await dio.post(
        ApiPath.LESSON_PLAN_DETAIL,
        data: formData,
      );
      if (response.statusCode == 200) {
        final result = LessonPlanDetailResponseModel.fromJson(response.data);
        if (result.success ?? false) {
          return Right(result.data!);
        } else {
          return Left(ExceptionModel(result.message ?? ''));
        }
      } else {
        return Left(ExceptionModel(response.data['message']));
      }
    } catch (e) {
      return Left(ExceptionModel(e.toString()));
    }
  }
}
