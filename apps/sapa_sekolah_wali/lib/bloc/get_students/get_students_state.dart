part of 'get_students_bloc.dart';

abstract class GetStudentsState {}

class GetStudentsInitial extends GetStudentsState {}

class GetStudentsSuccess extends GetStudentsState {
  final List<StudentModel> students;
  GetStudentsSuccess({required this.students});
}

class GetStudentsLoading extends GetStudentsState {}

class GetStudentsError extends GetStudentsState {
  final String message;
  GetStudentsError({required this.message});
}
