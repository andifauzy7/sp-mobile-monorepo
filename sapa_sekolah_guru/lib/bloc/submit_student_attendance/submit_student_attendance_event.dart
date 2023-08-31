part of 'submit_student_attendance_bloc.dart';

class SubmitStudentAttendanceEvent {
  final DateTime dateTime;
  final List<StudentAttendanceModel> attendances;

  SubmitStudentAttendanceEvent({
    required this.dateTime,
    required this.attendances,
  });
}
