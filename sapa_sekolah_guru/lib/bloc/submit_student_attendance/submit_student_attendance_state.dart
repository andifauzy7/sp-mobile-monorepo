part of 'submit_student_attendance_bloc.dart';

abstract class SubmitStudentAttendanceState {}

class SubmitStudentAttendanceInitial extends SubmitStudentAttendanceState {}

class SubmitStudentAttendanceSuccess extends SubmitStudentAttendanceState {}

class SubmitStudentAttendanceLoading extends SubmitStudentAttendanceState {}

class SubmitStudentAttendanceError extends SubmitStudentAttendanceState {
  final String message;
  SubmitStudentAttendanceError({required this.message});
}
