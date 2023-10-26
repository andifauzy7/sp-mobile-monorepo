import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_wali/repositories/consultation_repository.dart';

part 'add_consultation_response_event.dart';
part 'add_consultation_response_state.dart';

@injectable
class AddConsultationResponseBloc
    extends Bloc<AddConsultationResponseEvent, AddConsultationResponseState> {
  final ConsultationRepository consultationRepository;
  AddConsultationResponseBloc({
    required this.consultationRepository,
  }) : super(AddConsultationResponseInitial()) {
    on<AddConsultationResponseEvent>((event, emit) async {
      emit(AddConsultationResponseLoading());
      final result = await consultationRepository.consultationAddResponse(
        event.consultationId,
        event.responseText,
      );
      result.fold(
        (failure) => emit(AddConsultationResponseError(
          message: failure.toString(),
        )),
        (_) => emit(AddConsultationResponseSuccess()),
      );
    });
  }
}
