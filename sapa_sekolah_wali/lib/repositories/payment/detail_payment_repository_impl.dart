import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:injectable/injectable.dart';
import 'package:sapa_sekolah_wali/model/payment/detail_payment_model.dart';
import 'package:sapa_sekolah_wali/model/exception_model.dart';
import 'package:sapa_sekolah_wali/repositories/payment/detail_payment_repository.dart';

import '../utils/api_path.dart';

@LazySingleton(as: DetailPaymentRepository)
class DetailPaymentRepositoryImpl implements DetailPaymentRepository {
  Dio dio;
  final esp = EncryptedSharedPreferences();

  DetailPaymentRepositoryImpl(this.dio);

  @override
  Future<Either<ExceptionModel, DetailPaymentModel>> getPaymentDetail(
      String studentId, String paymentId) async {
    final sp = await esp.getInstance();
    final token = sp.getString('token');
    final userId = sp.getString('user_id');

    final formData = FormData.fromMap({
      "token": token,
      "user_id": userId,
      "student_id": studentId,
      "payment_id": paymentId,
    });

    try {
      final response = await dio.post(ApiPath.PAYMENT_DETAIL, data: formData);
      final data = (response.data['data'] as List)[0];
      final result = DetailPaymentModel.fromJson(data);
      return Right(result);
    } catch (e) {
      return Left(ExceptionModel(e.toString()));
    }
  }
}
