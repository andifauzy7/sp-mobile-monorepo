part of 'add_lesson_plan_bloc.dart';

abstract class AddLessonPlanState {}

class AddLessonPlanInitial extends AddLessonPlanState {}

class AddLessonPlanSuccess extends AddLessonPlanState {}

class AddLessonPlanLoading extends AddLessonPlanState {}

class AddLessonPlanError extends AddLessonPlanState {
  final String message;
  AddLessonPlanError({required this.message});
}
