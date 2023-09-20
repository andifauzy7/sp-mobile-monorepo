part of 'get_attendances_bloc.dart';

@immutable
abstract class GetAttendancesState {}

class GetAttendancesInitial extends GetAttendancesState {}

class GetAttendancesSuccess extends GetAttendancesState {
  final List<AttendanceModel> attendances;
  GetAttendancesSuccess({required this.attendances});
}

class GetAttendancesLoading extends GetAttendancesState {}

class GetAttendancesError extends GetAttendancesState {
  final String message;
  GetAttendancesError({required this.message});
}
