import 'package:sapa_component/sapa_component.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_guru/repositories/permit_repository.dart';

part 'add_permit_event.dart';
part 'add_permit_state.dart';

@injectable
class AddPermitBloc extends Bloc<AddPermitEvent, AddPermitState> {
  final PermitRepository permitRepository;
  AddPermitBloc({
    required this.permitRepository,
  }) : super(AddPermitInitial()) {
    on<AddPermitEvent>((event, emit) async {
      emit(AddPermitLoading());
      final result = await permitRepository.addPermit(
        event.studentId,
        event.permitType,
        DateFormat("yyyy-MM-dd").format(event.dateStart),
        DateFormat("yyyy-MM-dd").format(event.dateEnd),
        event.notes,
      );
      result.fold(
        (failure) => emit(AddPermitError(
          message: failure.toString(),
        )),
        (_) => emit(AddPermitSuccess()),
      );
    });
  }
}
