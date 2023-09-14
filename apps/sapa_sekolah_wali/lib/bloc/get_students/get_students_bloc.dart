import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_wali/model/students_response_model.dart';
import 'package:sapa_sekolah_wali/repositories/student_repository.dart';

part 'get_students_event.dart';
part 'get_students_state.dart';

@injectable
class GetStudentsBloc extends Bloc<GetStudentsEvent, GetStudentsState> {
  final StudentRepository studentRepository;
  GetStudentsBloc({
    required this.studentRepository,
  }) : super(GetStudentsInitial()) {
    on<GetStudentsEvent>((event, emit) async {
      emit(GetStudentsLoading());
      final result = await studentRepository.getStudents();
      result.fold(
        (failure) => emit(GetStudentsError(
          message: failure.toString(),
        )),
        (students) => emit(GetStudentsSuccess(
          students: students,
        )),
      );
    });
  }
}
