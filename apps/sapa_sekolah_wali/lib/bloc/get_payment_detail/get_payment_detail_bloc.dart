import 'package:flutter/material.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_wali/model/payment_detail_response_model.dart';
import 'package:sapa_sekolah_wali/repositories/payment_repository.dart';

part 'get_payment_detail_event.dart';
part 'get_payment_detail_state.dart';

@injectable
class GetPaymentDetailBloc
    extends Bloc<GetPaymentDetailEvent, GetPaymentDetailState> {
  final PaymentRepository paymentRepository;
  GetPaymentDetailBloc({
    required this.paymentRepository,
  }) : super(GetPaymentDetailInitial()) {
    on<GetPaymentDetailEvent>((event, emit) async {
      emit(GetPaymentDetailLoading());
      final result = await paymentRepository.getPaymentDetail(
        event.studentId,
        event.paymentId,
      );
      result.fold(
        (failure) => emit(GetPaymentDetailError(
          message: failure.toString(),
        )),
        (paymentDetail) => emit(GetPaymentDetailSuccess(
          paymentDetail: paymentDetail,
        )),
      );
    });
  }
}
