import 'package:sapa_core/failure/failure.dart';
import 'package:sapa_core/failure/server_failure.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_wali/model/payments_response_model.dart';
import 'package:sapa_sekolah_wali/repositories/auth_repository.dart';

abstract class PaymentRepository {
  Future<Either<Failure, List<PaymentModel>>> getPayments(
    String studentId,
  );
}

@LazySingleton(as: PaymentRepository)
class PaymentRepositoryImpl implements PaymentRepository {
  final Dio dio;
  final SharedPreferences sharedPreferences;

  PaymentRepositoryImpl({
    required this.dio,
    required this.sharedPreferences,
  });

  @override
  Future<Either<Failure, List<PaymentModel>>> getPayments(
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
        'paymentlist.php',
        data: data,
      );
      if (response.statusCode == 200) {
        final result = PaymentsResponseModel.fromJson(response.data);
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
