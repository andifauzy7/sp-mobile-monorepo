part of 'get_teacher_detail_bloc.dart';

@immutable
abstract class GetTeacherDetailState {}

class GetTeacherDetailInitial extends GetTeacherDetailState {}

class GetTeacherDetailSuccess extends GetTeacherDetailState {
  final TeacherDetailModel teacherDetail;
  GetTeacherDetailSuccess({required this.teacherDetail});
}

class GetTeacherDetailLoading extends GetTeacherDetailState {}

class GetTeacherDetailError extends GetTeacherDetailState {
  final String message;
  GetTeacherDetailError({required this.message});
}
