import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:sapa_sekolah_guru/model/students_attendance_response_model.dart';
import 'package:sapa_sekolah_guru/repositories/attendance_repository.dart';

part 'get_students_attendance_event.dart';
part 'get_students_attendance_state.dart';

@injectable
class GetStudentsAttendanceBloc
    extends Bloc<GetStudentsAttendanceEvent, GetStudentsAttendanceState> {
  final AttendanceRepository attendanceRepository;
  GetStudentsAttendanceBloc({
    required this.attendanceRepository,
  }) : super(GetStudentsAttendanceInitial()) {
    on<GetStudentsAttendanceEvent>((event, emit) async {
      emit(GetStudentsAttendanceLoading());
      final result = await attendanceRepository.getStudentsAttendance(
        DateFormat("yyyy-MM-dd").format(
          event.dateTime,
        ),
      );
      result.fold(
        (failure) => emit(GetStudentsAttendanceError(
          message: failure.toString(),
        )),
        (attendances) => emit(GetStudentsAttendanceSuccess(
          attendances: attendances,
        )),
      );
    });
  }
}
