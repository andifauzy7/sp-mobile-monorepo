import 'package:sapa_core/failure/failure.dart';
import 'package:sapa_core/failure/server_failure.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_wali/model/daily_report_detail_response_model.dart';
import 'package:sapa_sekolah_wali/model/daily_reports_response_model.dart';
import 'package:sapa_sekolah_wali/repositories/auth_repository.dart';

abstract class ReportRepository {
  Future<Either<Failure, List<DailyReportModel>>> getDailyReports(
    String studentId,
  );
  Future<Either<Failure, DailyReportDetailModel>> getDailyReportDetail(
    String reportId,
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
}
