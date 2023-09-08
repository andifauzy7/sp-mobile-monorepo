part of 'list_payment_bloc.dart';

@freezed
class ListPaymentState with _$ListPaymentState {
  const factory ListPaymentState.initial() = _Initial;
  const factory ListPaymentState.loading() = _Loading;
  const factory ListPaymentState.failure(String message) = _Failure;
  const factory ListPaymentState.success(List<ListPaymentModel> payload) = _Success;
}
