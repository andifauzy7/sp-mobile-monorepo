import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:sapa_sekolah_guru/model/daily_report_detail_response_model.dart';
import 'package:sapa_sekolah_guru/model/daily_reports_response_model.dart';
import 'package:sapa_sekolah_guru/model/update_daily_report_response_model.dart';
import 'package:sapa_sekolah_guru/repositories/auth_repository.dart';
import 'package:sapa_sekolah_guru/shared/core/failure/failure.dart';
import 'package:sapa_sekolah_guru/shared/core/failure/server_failure.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ReportRepository {
  Future<Either<Failure, List<DailyReportModel>>> getDailyReports(
    String studentId,
  );
  Future<Either<Failure, DailyReportDetailModel>> getDailyReportDetail(
    String reportId,
  );
  Future<Either<Failure, bool>> updateDailyReport(
    String? reportDailyId,
    String reportDate,
    String studentId,
    String completeWork,
    String qualityWork,
    String needToWork,
    String behaviorSchool,
    String improvement,
  );
}

@LazySingleton(as: ReportRepository)
class ReportRepositoryImpl implements ReportRepository {
  final Dio dio;
  final SharedPreferences sharedPreferences;

  ReportRepositoryImpl({
    required this.dio,
    required this.sharedPreferences,
  });

  @override
  Future<Either<Failure, List<DailyReportModel>>> getDailyReports(
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
        'teacher/reportdailylist.php',
        data: data,
      );
      if (response.statusCode == 200) {
        final result = DailyReportsResponseModel.fromJson(response.data);
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
  Future<Either<Failure, DailyReportDetailModel>> getDailyReportDetail(
    String reportId,
  ) async {
    final token = sharedPreferences.getString(keyToken);
    final userId = sharedPreferences.getString(keyUserId);
    final data = FormData.fromMap({
      "token": token,
      "user_id": userId,
      "report_daily_id": reportId,
    });
    try {
      final response = await dio.post(
        'teacher/reportdailydetail.php',
        data: data,
      );
      if (response.statusCode == 200) {
        final result = DailyReportDetailResponseModel.fromJson(response.data);
        if ((result.success == true) && (result.data?.isNotEmpty == true)) {
          return Right(result.data!.first);
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
  Future<Either<Failure, bool>> updateDailyReport(
    String? reportDailyId,
    String reportDate,
    String studentId,
    String completeWork,
    String qualityWork,
    String needToWork,
    String behaviorSchool,
    String improvement,
  ) async {
    final token = sharedPreferences.getString(keyToken);
    final userId = sharedPreferences.getString(keyUserId);
    final data = FormData.fromMap({
      "token": token,
      "user_id": userId,
      "report_daily_id": reportDailyId ?? '',
      "report_date": reportDate,
      "student_id": studentId,
      "complete_work": completeWork,
      "quality_work": qualityWork,
      "need_work": needToWork,
      "behavior_school": behaviorSchool,
      "improvement": improvement,
    });
    try {
      final response = await dio.post(
        'teacher/reportdailysubmit.php',
        data: data,
      );
      if (response.statusCode == 200) {
        final result = UpdateDailyReportResponseModel.fromJson(response.data);
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
