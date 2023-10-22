import 'package:sapa_core/failure/failure.dart';
import 'package:sapa_core/failure/server_failure.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_wali/model/add_consultation_response_model.dart';
import 'package:sapa_sekolah_wali/model/consultations_response_model.dart';
import 'package:sapa_sekolah_wali/repositories/auth_repository.dart';

abstract class ConsultationRepository {
  Future<Either<Failure, List<ConsultationModel>>> getConsultations();
  Future<Either<Failure, bool>> addConsultation(
    String studentId,
    String teacherId,
    String questionText,
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
  Future<Either<Failure, bool>> addConsultation(
    String studentId,
    String teacherId,
    String questionText,
  ) async {
    final token = sharedPreferences.getString(keyToken);
    final userId = sharedPreferences.getString(keyUserId);
    final data = FormData.fromMap({
      "token": token,
      "user_id": userId,
      "student_id": studentId,
      "employee_id": teacherId,
      "question_text": questionText,
    });
    try {
      final response = await dio.post(
        'consultationaddquestion.php',
        data: data,
      );
      if (response.statusCode == 200) {
        final result = AddConsultationPlanResponseModel.fromJson(response.data);
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
  Future<Either<Failure, List<ConsultationModel>>> getConsultations() async {
    final token = sharedPreferences.getString(keyToken);
    final userId = sharedPreferences.getString(keyUserId);
    final data = FormData.fromMap({
      "token":
          "Zjg3a1dlUHJWS2RHMGF4bTU4N2toVGY2VlUzRnNFcUg3SWVaMURmbHJCOGs2T2ZMcFFVL09CeTZtWFV2bmlBRw==",
      "user_id": "6",
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
