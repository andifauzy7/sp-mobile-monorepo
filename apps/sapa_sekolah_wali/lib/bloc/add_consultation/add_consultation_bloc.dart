import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_wali/repositories/consultation_repository.dart';

part 'add_consultation_event.dart';
part 'add_consultation_state.dart';

@injectable
class AddConsultationBloc
    extends Bloc<AddConsultationEvent, AddConsultationState> {
  final ConsultationRepository consultationRepository;
  AddConsultationBloc({
    required this.consultationRepository,
  }) : super(AddConsultationInitial()) {
    on<AddConsultationEvent>((event, emit) async {
      emit(AddConsultationLoading());
      final result = await consultationRepository.addConsultation(
        event.studentId,
        event.teacherId,
        event.questionText,
      );
      result.fold(
        (failure) => emit(AddConsultationError(
          message: failure.toString(),
        )),
        (_) => emit(AddConsultationSuccess()),
      );
    });
  }
}
