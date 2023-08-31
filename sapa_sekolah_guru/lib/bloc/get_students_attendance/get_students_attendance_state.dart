part of 'get_students_attendance_bloc.dart';

abstract class GetStudentsAttendanceState {}

class GetStudentsAttendanceInitial extends GetStudentsAttendanceState {}

class GetStudentsAttendanceSuccess extends GetStudentsAttendanceState {
  final List<StudentAttendanceModel> attendances;
  GetStudentsAttendanceSuccess({required this.attendances});
}

class GetStudentsAttendanceLoading extends GetStudentsAttendanceState {}

class GetStudentsAttendanceError extends GetStudentsAttendanceState {
  final String message;
  GetStudentsAttendanceError({required this.message});
}
