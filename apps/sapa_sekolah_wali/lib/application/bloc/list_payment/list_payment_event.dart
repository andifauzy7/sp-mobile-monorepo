part of 'list_payment_bloc.dart';

@freezed
class ListPaymentEvent with _$ListPaymentEvent {
  const factory ListPaymentEvent.started() = _Started;
  const factory ListPaymentEvent.load(int studentId) = _Load;
}
