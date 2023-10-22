import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_wali/model/consultations_response_model.dart';
import 'package:sapa_sekolah_wali/repositories/consultation_repository.dart';

part 'get_consultations_event.dart';
part 'get_consultations_state.dart';

@injectable
class GetConsultationsBloc
    extends Bloc<GetConsultationsEvent, GetConsultationsState> {
  final ConsultationRepository consultationRepository;
  GetConsultationsBloc({
    required this.consultationRepository,
  }) : super(GetConsultationsInitial()) {
    on<GetConsultationsEvent>((event, emit) async {
      emit(GetConsultationsLoading());
      final result = await consultationRepository.getConsultations();
      result.fold(
        (failure) => emit(GetConsultationsError(
          message: failure.toString(),
        )),
        (consultations) => emit(GetConsultationsSuccess(
          consultations: consultations,
        )),
      );
    });
  }
}
