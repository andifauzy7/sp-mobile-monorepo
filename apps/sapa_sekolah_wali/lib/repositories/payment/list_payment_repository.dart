import 'package:dartz/dartz.dart';
import 'package:sapa_sekolah_wali/model/exception_model.dart';
import 'package:sapa_sekolah_wali/model/payment/list_payment_model.dart';

abstract class ListPaymentRepository {
  Future<Either<ExceptionModel, List<ListPaymentModel>>> getListPayment(
      int studentId);
}
