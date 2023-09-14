part of 'get_student_detail_bloc.dart';

@immutable
abstract class GetStudentDetailState {}

class GetStudentDetailInitial extends GetStudentDetailState {}

class GetStudentDetailSuccess extends GetStudentDetailState {
  final StudentDetailModel studentDetail;
  GetStudentDetailSuccess({required this.studentDetail});
}

class GetStudentDetailLoading extends GetStudentDetailState {}

class GetStudentDetailError extends GetStudentDetailState {
  final String message;
  GetStudentDetailError({required this.message});
}
