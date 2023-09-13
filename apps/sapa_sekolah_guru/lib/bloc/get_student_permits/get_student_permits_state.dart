part of 'get_student_permits_bloc.dart';

abstract class GetStudentPermitsState {}

class GetStudentPermitsInitial extends GetStudentPermitsState {}

class GetStudentPermitsSuccess extends GetStudentPermitsState {
  final List<StudentPermitModel> permits;
  GetStudentPermitsSuccess({required this.permits});
}

class GetStudentPermitsLoading extends GetStudentPermitsState {}

class GetStudentPermitsError extends GetStudentPermitsState {
  final String message;
  GetStudentPermitsError({required this.message});
}
