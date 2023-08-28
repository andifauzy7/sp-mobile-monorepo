import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sapa_sekolah_guru/model/student_permits_response_model.dart';
import 'package:sapa_sekolah_guru/repositories/permit_repository.dart';

part 'get_student_permits_event.dart';
part 'get_student_permits_state.dart';

@injectable
class GetStudentPermitsBloc
    extends Bloc<GetStudentPermitsEvent, GetStudentPermitsState> {
  final PermitRepository permitRepository;
  GetStudentPermitsBloc({
    required this.permitRepository,
  }) : super(GetStudentPermitsInitial()) {
    on<GetStudentPermitsEvent>((event, emit) async {
      emit(GetStudentPermitsLoading());
      final result = await permitRepository.getStudentPermits();
      result.fold(
        (failure) => emit(GetStudentPermitsError(
          message: failure.toString(),
        )),
        (permits) => emit(GetStudentPermitsSuccess(
          permits: permits,
        )),
      );
    });
  }
}
