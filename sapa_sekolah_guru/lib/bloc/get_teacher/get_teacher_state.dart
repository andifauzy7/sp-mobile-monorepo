part of 'get_teacher_bloc.dart';

abstract class GetTeacherState {}

class GetTeacherInitial extends GetTeacherState {}

class GetTeacherSuccess extends GetTeacherState {
  final TeacherModel teacher;
  GetTeacherSuccess({required this.teacher});
}

class GetTeacherLoading extends GetTeacherState {}

class GetTeacherError extends GetTeacherState {
  final String message;
  GetTeacherError({required this.message});
}
