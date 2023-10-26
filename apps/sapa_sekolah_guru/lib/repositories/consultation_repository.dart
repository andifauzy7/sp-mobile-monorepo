import 'package:sapa_core/failure/failure.dart';
import 'package:sapa_core/failure/server_failure.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_guru/model/add_consultation_response_response_model.dart';
import 'package:sapa_sekolah_guru/model/consultation_detail_response_model.dart';
import 'package:sapa_sekolah_guru/model/consultations_response_model.dart';
import 'package:sapa_sekolah_guru/repositories/auth_repository.dart';

abstract class ConsultationRepository {
  Future<Either<Failure, List<ConsultationModel>>> getConsultations();
  Future<Either<Failure, ConsultationDetailModel>> getConsultationDetail(
    String id,
  );
  Future<Either<Failure, bool>> consultationAddResponse(
    String consultationId,
    String responseText,
  );
}

@LazySingleton(as: ConsultationRepository)
class ConsultationRepositoryImpl implements ConsultationRepository {
  final Dio dio;
  final SharedPreferences sharedPreferences;

  ConsultationRepositoryImpl({
    required this.dio,
    required this.sharedPreferences,
  });

  @override
  Future<Either<Failure, List<ConsultationModel>>> getConsultations() async {
    final token = sharedPreferences.getString(keyToken);
    final userId = sharedPreferences.getString(keyUserId);
    final data = FormData.fromMap({
      "token": token,
      "user_id": userId,
    });
    try {
      final response = await dio.post(
        'consultationlist.php',
        data: data,
      );
      if (response.statusCode == 200) {
        final result = ConsultationsResponseModel.fromJson(response.data);
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
  Future<Either<Failure, ConsultationDetailModel>> getConsultationDetail(
    String id,
  ) async {
    final token = sharedPreferences.getString(keyToken);
    final userId = sharedPreferences.getString(keyUserId);
    final data = FormData.fromMap({
      "token": token,
      "user_id": userId,
      "consultation_id": id,
    });
    try {
      final response = await dio.post(
        'consultationdetail.php',
        data: data,
      );
      if (response.statusCode == 200) {
        final result = ConsultationDetailResponseModel.fromJson(response.data);
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

  @override
  Future<Either<Failure, bool>> consultationAddResponse(
    String consultationId,
    String responseText,
  ) async {
    final token = sharedPreferences.getString(keyToken);
    final userId = sharedPreferences.getString(keyUserId);
    final data = FormData.fromMap({
      "token": token,
      "user_id": userId,
      "consultation_id": consultationId,
      "response_text": responseText,
      "response_file": "",
      "response_from": "2",
    });
    try {
      final response = await dio.post(
        'consultationaddresponse.php',
        data: data,
      );
      if (response.statusCode == 200) {
        final result = AddConsultationResponseResponseModel.fromJson(
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
