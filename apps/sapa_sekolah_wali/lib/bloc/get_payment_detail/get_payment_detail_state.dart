part of 'get_payment_detail_bloc.dart';

@immutable
abstract class GetPaymentDetailState {}

class GetPaymentDetailInitial extends GetPaymentDetailState {}

class GetPaymentDetailSuccess extends GetPaymentDetailState {
  final PaymentDetailModel paymentDetail;
  GetPaymentDetailSuccess({required this.paymentDetail});
}

class GetPaymentDetailLoading extends GetPaymentDetailState {}

class GetPaymentDetailError extends GetPaymentDetailState {
  final String message;
  GetPaymentDetailError({required this.message});
}
