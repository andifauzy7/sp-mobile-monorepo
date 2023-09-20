import 'package:flutter/material.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_wali/model/attendances_response_model.dart';
import 'package:sapa_sekolah_wali/repositories/attendance_repository.dart';

part 'get_attendances_event.dart';
part 'get_attendances_state.dart';

@injectable
class GetAttendancesBloc
    extends Bloc<GetAttendancesEvent, GetAttendancesState> {
  final AttendanceRepository attendanceRepository;
  GetAttendancesBloc({
    required this.attendanceRepository,
  }) : super(GetAttendancesInitial()) {
    on<GetAttendancesEvent>((event, emit) async {
      emit(GetAttendancesLoading());
      final result = await attendanceRepository.getAttendances(
        event.studentId,
        event.month,
        event.year,
      );
      result.fold(
        (failure) => emit(GetAttendancesError(
          message: failure.toString(),
        )),
        (result) => emit(GetAttendancesSuccess(
          attendances: result,
        )),
      );
    });
  }
}
