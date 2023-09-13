part of 'add_lesson_bloc.dart';

abstract class AddLessonState {}

class AddLessonInitial extends AddLessonState {}

class AddLessonSuccess extends AddLessonState {}

class AddLessonLoading extends AddLessonState {}

class AddLessonError extends AddLessonState {
  final String message;
  AddLessonError({required this.message});
}
