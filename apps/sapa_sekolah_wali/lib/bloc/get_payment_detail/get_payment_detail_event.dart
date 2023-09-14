part of 'get_payment_detail_bloc.dart';

class GetPaymentDetailEvent {
  final String paymentId;
  final String studentId;
  GetPaymentDetailEvent({
    required this.paymentId,
    required this.studentId,
  });
}
