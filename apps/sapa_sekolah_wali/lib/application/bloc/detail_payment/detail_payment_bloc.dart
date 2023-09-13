import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sapa_sekolah_wali/model/payment/detail_payment_model.dart';
import 'package:sapa_sekolah_wali/repositories/payment/detail_payment_repository.dart';

part 'detail_payment_event.dart';
part 'detail_payment_state.dart';
part 'detail_payment_bloc.freezed.dart';

@injectable
class DetailPaymentBloc extends Bloc<DetailPaymentEvent, DetailPaymentState> {
  final DetailPaymentRepository repository;

  DetailPaymentBloc(this.repository) : super(const _Initial()) {
    on<DetailPaymentEvent>((event, emit) async {
      await event.map(
        started: (started) {},
        load: (load) async {
          emit(const DetailPaymentState.loading());

          final result =
              await repository.getPaymentDetail(load.studentId, load.paymentId);

          result.fold(
            (l) {
              emit(DetailPaymentState.failure(l.message));
            },
            (r) {
              emit(DetailPaymentState.success(r));
            },
          );
        },
      );
    });
  }
}
