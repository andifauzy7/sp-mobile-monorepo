import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_guru/model/consultation_detail_response_model.dart';
import 'package:sapa_sekolah_guru/repositories/consultation_repository.dart';

part 'get_consultation_detail_event.dart';
part 'get_consultation_detail_state.dart';

@injectable
class GetConsultationDetailBloc
    extends Bloc<GetConsultationDetailEvent, GetConsultationDetailState> {
  final ConsultationRepository consultationRepository;
  GetConsultationDetailBloc({
    required this.consultationRepository,
  }) : super(GetConsultationDetailInitial()) {
    on<GetConsultationDetailEvent>((event, emit) async {
      emit(GetConsultationDetailLoading());
      final result =
          await consultationRepository.getConsultationDetail(event.id);
      result.fold(
        (failure) => emit(GetConsultationDetailError(
          message: failure.toString(),
        )),
        (result) => emit(GetConsultationDetailSuccess(
          consultation: result,
        )),
      );
    });
  }
}
