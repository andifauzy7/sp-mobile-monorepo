import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:sapa_sekolah_guru/model/students_attendance_response_model.dart';
import 'package:sapa_sekolah_guru/repositories/attendance_repository.dart';

part 'submit_student_attendance_event.dart';
part 'submit_student_attendance_state.dart';

@injectable
class SubmitStudentAttendanceBloc
    extends Bloc<SubmitStudentAttendanceEvent, SubmitStudentAttendanceState> {
  final AttendanceRepository attendanceRepository;
  SubmitStudentAttendanceBloc({
    required this.attendanceRepository,
  }) : super(SubmitStudentAttendanceInitial()) {
    on<SubmitStudentAttendanceEvent>((event, emit) async {
      emit(SubmitStudentAttendanceLoading());
      final result = await attendanceRepository.submitStudentAttendance(
        DateFormat("yyyy-MM-dd").format(event.dateTime),
        event.attendances,
      );
      result.fold(
        (failure) => emit(SubmitStudentAttendanceError(
          message: failure.toString(),
        )),
        (_) => emit(SubmitStudentAttendanceSuccess()),
      );
    });
  }
}
