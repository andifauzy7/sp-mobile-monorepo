import 'dart:convert';

import 'package:sapa_core/failure/failure.dart';
import 'package:sapa_core/failure/server_failure.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_guru/model/daily_report_detail_response_model.dart';
import 'package:sapa_sekolah_guru/model/daily_reports_response_model.dart';
import 'package:sapa_sekolah_guru/model/delete_monthly_report_response_model.dart';
import 'package:sapa_sekolah_guru/model/monthly_report_component_response_model.dart';
import 'package:sapa_sekolah_guru/model/monthly_report_detail_response_model.dart';
import 'package:sapa_sekolah_guru/model/monthly_reports_response_model.dart';
import 'package:sapa_sekolah_guru/model/update_daily_report_response_model.dart';
import 'package:sapa_sekolah_guru/model/update_monthly_report_response_model.dart';
import 'package:sapa_sekolah_guru/repositories/auth_repository.dart';

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
  Future<Either<Failure, List<MonthlyReportModel>>> getMonthlyReports(
    String studentId,
  );
  Future<Either<Failure, MonthlyReportDetailModel>> getMonthlyReportDetail(
    String reportId,
    String studentId,
  );
  Future<Either<Failure, bool>> deleteMonthlyReport(
    String reportMonthlyId,
  );
  Future<Either<Failure, List<MonthlyReportComponentModel>>>
      getMonthlyReportComponent();
  Future<Either<Failure, bool>> updateMonthlyReport(
    String? reportMonthlyId,
    String reportDate,
    String studentId,
    List<Map<String, String>> reportMonthly,
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
        'reportdailylist.php',
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
        'reportdailydetail.php',
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
        'reportdailysubmit.php',
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

  @override
  Future<Either<Failure, List<MonthlyReportModel>>> getMonthlyReports(
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
        'reportmonthlylist.php',
        data: data,
      );
      if (response.statusCode == 200) {
        final result = MonthlyReportsResponseModel.fromJson(response.data);
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
  Future<Either<Failure, MonthlyReportDetailModel>> getMonthlyReportDetail(
    String reportId,
    String studentId,
  ) async {
    final token = sharedPreferences.getString(keyToken);
    final userId = sharedPreferences.getString(keyUserId);
    final data = FormData.fromMap({
      "token": token,
      "user_id": userId,
      "report_monthly_id": reportId,
      "student_id": studentId,
    });
    try {
      final response = await dio.post(
        'reportmonthlydetail.php',
        data: data,
      );
      if (response.statusCode == 200) {
        final result = MonthlyReportDetailResponseModel.fromJson(response.data);
        if ((result.success == true)) {
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

  @override
  Future<Either<Failure, bool>> deleteMonthlyReport(
    String reportMonthlyId,
  ) async {
    final token = sharedPreferences.getString(keyToken);
    final userId = sharedPreferences.getString(keyUserId);
    final data = FormData.fromMap({
      "token": token,
      "user_id": userId,
      "report_monthly_id": reportMonthlyId,
    });
    try {
      final response = await dio.post(
        'reportmonthlydelete.php',
        data: data,
      );
      if (response.statusCode == 200) {
        final result = DeleteMonthlyReportResponseModel.fromJson(
          response.data,
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

  @override
  Future<Either<Failure, List<MonthlyReportComponentModel>>>
      getMonthlyReportComponent() async {
    try {
      final response = await dio.post(
        'reportmonthlycomponent.php',
      );
      if (response.statusCode == 200) {
        final result = MonthlyReportComponentResponseModel.fromJson(
          response.data,
        );
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
  Future<Either<Failure, bool>> updateMonthlyReport(
    String? reportMonthlyId,
    String reportDate,
    String studentId,
    List<Map<String, String>> reportMonthly,
  ) async {
    final token = sharedPreferences.getString(keyToken);
    final userId = sharedPreferences.getString(keyUserId);
    final data = FormData.fromMap({
      "token": token,
      "user_id": userId,
      "report_monthly_id": reportMonthlyId ?? '',
      "report_date": reportDate,
      "student_id": studentId,
      "report_monthly": jsonEncode(reportMonthly),
    });
    try {
      final response = await dio.post(
        'reportmonthlysubmit.php',
        data: data,
      );
      if (response.statusCode == 200) {
        final result = UpdateMonthlyReportResponseModel.fromJson(response.data);
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
