import 'package:flutter/material.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_wali/model/payments_response_model.dart';
import 'package:sapa_sekolah_wali/repositories/payment_repository.dart';

part 'get_payments_event.dart';
part 'get_payments_state.dart';

@injectable
class GetPaymentsBloc extends Bloc<GetPaymentsEvent, GetPaymentsState> {
  final PaymentRepository paymentRepository;
  GetPaymentsBloc({
    required this.paymentRepository,
  }) : super(GetPaymentsInitial()) {
    on<GetPaymentsEvent>((event, emit) async {
      emit(GetPaymentsLoading());
      final result = await paymentRepository.getPayments(
        event.studentId,
      );
      result.fold(
        (failure) => emit(GetPaymentsError(
          message: failure.toString(),
        )),
        (payments) => emit(GetPaymentsSuccess(
          payments: payments,
        )),
      );
    });
  }
}
