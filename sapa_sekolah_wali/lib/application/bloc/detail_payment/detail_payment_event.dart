part of 'detail_payment_bloc.dart';

@freezed
class DetailPaymentEvent with _$DetailPaymentEvent {
  const factory DetailPaymentEvent.started() = _Started;
  const factory DetailPaymentEvent.load(String studentId, String paymentId) =
      _Load;
}
