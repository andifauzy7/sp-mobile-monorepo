part of 'get_teachers_bloc.dart';

@immutable
abstract class GetTeachersState {}

class GetTeachersInitial extends GetTeachersState {}

class GetTeachersSuccess extends GetTeachersState {
  final List<TeacherModel> teachers;
  GetTeachersSuccess({required this.teachers});
}

class GetTeachersLoading extends GetTeachersState {}

class GetTeachersError extends GetTeachersState {
  final String message;
  GetTeachersError({required this.message});
}
