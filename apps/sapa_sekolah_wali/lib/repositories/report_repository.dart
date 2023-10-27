import 'package:sapa_core/failure/failure.dart';
import 'package:sapa_core/failure/server_failure.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_wali/model/add_monthly_report_response_response_model.dart';
import 'package:sapa_sekolah_wali/model/daily_report_detail_response_model.dart';
import 'package:sapa_sekolah_wali/model/daily_reports_response_model.dart';
import 'package:sapa_sekolah_wali/model/monthly_report_detail_response_model.dart';
import 'package:sapa_sekolah_wali/model/monthly_reports_response_model.dart';
import 'package:sapa_sekolah_wali/repositories/auth_repository.dart';

abstract class ReportRepository {
  Future<Either<Failure, List<DailyReportModel>>> getDailyReports(
    String studentId,
  );
  Future<Either<Failure, DailyReportDetailModel>> getDailyReportDetail(
    String reportId,
  );
  Future<Either<Failure, List<MonthlyReportModel>>> getMonthlyReports(
    String studentId,
  );
  Future<Either<Failure, MonthlyReportDetailModel>> getMonthlyReportDetail(
    String reportId,
    String studentId,
  );
  Future<Either<Failure, bool>> addMonthlyReportResponse(
    String reportId,
    String studentId,
    String message,
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
  Future<Either<Failure, bool>> addMonthlyReportResponse(
    String reportId,
    String studentId,
    String message,
  ) async {
    final token = sharedPreferences.getString(keyToken);
    final userId = sharedPreferences.getString(keyUserId);
    final data = FormData.fromMap({
      "token": token,
      "user_id": userId,
      "student_id": studentId,
      "report_monthly_id": reportId,
      "response_text": message,
    });
    try {
      final response = await dio.post(
        'reportmonthlyresponse.php',
        data: data,
      );
      if (response.statusCode == 200) {
        final result = AddMonthlyReportResponseResponseModel.fromJson(
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
}
