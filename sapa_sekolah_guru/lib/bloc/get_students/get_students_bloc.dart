import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sapa_sekolah_guru/model/students_response_model.dart';
import 'package:sapa_sekolah_guru/repositories/student_repository.dart';

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
