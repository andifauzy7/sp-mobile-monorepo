import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sapa_sekolah_wali/model/payment/list_payment_model.dart';
import 'package:sapa_sekolah_wali/repositories/payment/list_payment_repository.dart';

part 'list_payment_event.dart';
part 'list_payment_state.dart';
part 'list_payment_bloc.freezed.dart';

@injectable
class ListPaymentBloc extends Bloc<ListPaymentEvent, ListPaymentState> {
  ListPaymentRepository repository;

  ListPaymentBloc(this.repository) : super(const _Initial()) {
    on<ListPaymentEvent>((event, emit) async {
      await event.map(
        started: (started) {},
        load: (load) async {
          emit(const ListPaymentState.loading());

          final result = await repository.getListPayment(load.studentId);

          result.fold(
            (l) {
              emit(ListPaymentState.failure(l.message));
            },
            (r) {
              emit(ListPaymentState.success(r));
            },
          );
        },
      );
    });
  }
}
