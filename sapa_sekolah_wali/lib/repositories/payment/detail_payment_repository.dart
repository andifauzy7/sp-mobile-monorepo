import 'package:dartz/dartz.dart';
import 'package:sapa_sekolah_wali/model/exception_model.dart';
import 'package:sapa_sekolah_wali/model/payment/detail_payment_model.dart';

abstract class DetailPaymentRepository {
  Future<Either<ExceptionModel, DetailPaymentModel>> getPaymentDetail(
      String studentId, String paymentId);
}
