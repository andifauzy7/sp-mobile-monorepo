import 'package:sapa_core/failure/failure.dart';
import 'package:sapa_core/failure/server_failure.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_guru/model/consultations_response_model.dart';
import 'package:sapa_sekolah_guru/repositories/auth_repository.dart';

abstract class ConsultationRepository {
  Future<Either<Failure, List<ConsultationModel>>> getConsultations();
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
}
