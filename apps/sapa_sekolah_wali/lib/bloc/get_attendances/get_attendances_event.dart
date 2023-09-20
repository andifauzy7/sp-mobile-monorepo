part of 'get_attendances_bloc.dart';

class GetAttendancesEvent {
  final String studentId;
  final String month;
  final String year;

  GetAttendancesEvent({
    required this.studentId,
    required this.month,
    required this.year,
  });
}
