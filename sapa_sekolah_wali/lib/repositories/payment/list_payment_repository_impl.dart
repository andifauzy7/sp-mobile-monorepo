import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:injectable/injectable.dart';
import 'package:sapa_sekolah_wali/model/payment/list_payment_model.dart';
import 'package:sapa_sekolah_wali/model/exception_model.dart';
import 'package:sapa_sekolah_wali/repositories/payment/list_payment_repository.dart';

import '../utils/api_path.dart';

@LazySingleton(as: ListPaymentRepository)
class ListPaymentRepositoryImpl implements ListPaymentRepository {
  Dio dio;
  final esp = EncryptedSharedPreferences();

  ListPaymentRepositoryImpl(this.dio);
  @override
  Future<Either<ExceptionModel, List<ListPaymentModel>>> getListPayment(
      int studentId) async {
    final sp = await esp.getInstance();
    final token = sp.getString('token');
    final userId = sp.getString('user_id');

    final formData = FormData.fromMap({
      "token": token,
      "user_id": userId,
      "student_id": studentId,
    });

    try {
      final response = await dio.post(ApiPath.PAYMENT_LIST, data: formData);
      final result = (response.data['data'] as List)
          .map((e) => ListPaymentModel.fromJson(e))
          .toList();
      return Right(result);
    } catch (e) {
      return Left(ExceptionModel(e.toString()));
    }
  }
}
