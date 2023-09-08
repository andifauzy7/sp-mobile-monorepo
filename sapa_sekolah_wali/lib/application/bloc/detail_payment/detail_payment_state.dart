part of 'detail_payment_bloc.dart';

@freezed
class DetailPaymentState with _$DetailPaymentState {
  const factory DetailPaymentState.initial() = _Initial;
  const factory DetailPaymentState.loading() = _Loading;
  const factory DetailPaymentState.failure(String message) = _Failure;
  const factory DetailPaymentState.success(DetailPaymentModel payload) = _Succcess;
}
