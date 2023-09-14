part of 'get_payments_bloc.dart';

@immutable
abstract class GetPaymentsState {}

class GetPaymentsInitial extends GetPaymentsState {}

class GetPaymentsSuccess extends GetPaymentsState {
  final List<PaymentModel> payments;
  GetPaymentsSuccess({required this.payments});
}

class GetPaymentsLoading extends GetPaymentsState {}

class GetPaymentsError extends GetPaymentsState {
  final String message;
  GetPaymentsError({required this.message});
}
