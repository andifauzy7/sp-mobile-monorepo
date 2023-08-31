import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:sapa_sekolah_guru/model/activities_response_model.dart';
import 'package:sapa_sekolah_guru/model/add_activity_response_model.dart';
import 'package:sapa_sekolah_guru/model/add_lesson_plan_response_model.dart';
import 'package:sapa_sekolah_guru/model/add_lesson_response_model.dart';
import 'package:sapa_sekolah_guru/model/lesson_plans_response_model.dart';
import 'package:sapa_sekolah_guru/model/lessons_response_model.dart';
import 'package:sapa_sekolah_guru/repositories/auth_repository.dart';
import 'package:sapa_sekolah_guru/shared/core/failure/failure.dart';
import 'package:sapa_sekolah_guru/shared/core/failure/server_failure.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LessonRepository {
  Future<Either<Failure, List<LessonModel>>> getLessons();
  Future<Either<Failure, List<ActivityModel>>> getActivities();
  Future<Either<Failure, List<LessonPlanModel>>> getLessonPlans(
      String lessonDate);
  Future<Either<Failure, bool>> addLesson(String lesson);
  Future<Either<Failure, bool>> addLessonPlan(
    String? lessonPlanId,
    String studentId,
    String datePlan,
    String lessonId,
    List<String> activityId,
  );
  Future<Either<Failure, bool>> addActivity(String activity);
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
  Future<Either<Failure, List<LessonModel>>> getLessons() async {
    final token = sharedPreferences.getString(keyToken);
    final userId = sharedPreferences.getString(keyUserId);
    final data = FormData.fromMap({
      "token": token,
      "user_id": userId,
    });
    try {
      final response = await dio.post(
        'teacher/lessonlist.php',
        data: data,
      );
      if (response.statusCode == 200) {
        final result = LessonsResponseModel.fromJson(response.data);
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
  Future<Either<Failure, bool>> addLesson(String lesson) async {
    final token = sharedPreferences.getString(keyToken);
    final userId = sharedPreferences.getString(keyUserId);
    final data = FormData.fromMap({
      "token": token,
      "user_id": userId,
      "lesson_name": lesson,
    });
    try {
      final response = await dio.post(
        'teacher/lessonadd.php',
        data: data,
      );
      if (response.statusCode == 200) {
        final result = AddLessonResponseModel.fromJson(response.data);
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
  Future<Either<Failure, List<ActivityModel>>> getActivities() async {
    final token = sharedPreferences.getString(keyToken);
    final userId = sharedPreferences.getString(keyUserId);
    final data = FormData.fromMap({
      "token": token,
      "user_id": userId,
    });
    try {
      final response = await dio.post(
        'teacher/activitylist.php',
        data: data,
      );
      if (response.statusCode == 200) {
        final result = ActivitiesResponseModel.fromJson(response.data);
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
  Future<Either<Failure, bool>> addActivity(String activity) async {
    final token = sharedPreferences.getString(keyToken);
    final userId = sharedPreferences.getString(keyUserId);
    final data = FormData.fromMap({
      "token": token,
      "user_id": userId,
      "activity_name": activity,
    });
    try {
      final response = await dio.post(
        'teacher/activityadd.php',
        data: data,
      );
      if (response.statusCode == 200) {
        final result = AddActivityResponseModel.fromJson(response.data);
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
  Future<Either<Failure, List<LessonPlanModel>>> getLessonPlans(
    String lessonDate,
  ) async {
    final token = sharedPreferences.getString(keyToken);
    final userId = sharedPreferences.getString(keyUserId);
    final data = FormData.fromMap({
      "token": token,
      "user_id": userId,
      "lesson_date": lessonDate,
    });
    try {
      final response = await dio.post(
        'teacher/lessonplanlist.php',
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
  Future<Either<Failure, bool>> addLessonPlan(
    String? lessonPlanId,
    String studentId,
    String datePlan,
    String lessonId,
    List<String> activityId,
  ) async {
    final token = sharedPreferences.getString(keyToken);
    final userId = sharedPreferences.getString(keyUserId);
    final data = FormData.fromMap({
      "token": token,
      "user_id": userId,
      "lessonplan_id": lessonPlanId ?? '',
      "student_id": studentId,
      "date_plan": datePlan,
      "lesson_id": lessonId,
      "activity_id": json.encode(activityId),
    });
    try {
      final response = await dio.post(
        'teacher/lessonplanadd.php',
        data: data,
      );
      if (response.statusCode == 200) {
        final result = AddLessonPlanResponseModel.fromJson(response.data);
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
