part of 'get_lessons_bloc.dart';

abstract class GetLessonsState {}

class GetLessonsInitial extends GetLessonsState {}

class GetLessonsSuccess extends GetLessonsState {
  final List<LessonModel> lessons;
  GetLessonsSuccess({required this.lessons});
}

class GetLessonsLoading extends GetLessonsState {}

class GetLessonsError extends GetLessonsState {
  final String message;
  GetLessonsError({required this.message});
}
