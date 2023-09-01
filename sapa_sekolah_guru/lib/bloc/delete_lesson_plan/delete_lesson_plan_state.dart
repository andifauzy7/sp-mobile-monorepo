part of 'delete_lesson_plan_bloc.dart';

abstract class DeleteLessonPlanState {}

class DeleteLessonPlanInitial extends DeleteLessonPlanState {}

class DeleteLessonPlanSuccess extends DeleteLessonPlanState {}

class DeleteLessonPlanLoading extends DeleteLessonPlanState {}

class DeleteLessonPlanError extends DeleteLessonPlanState {
  final String message;
  DeleteLessonPlanError({required this.message});
}
