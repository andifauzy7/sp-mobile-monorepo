part of 'get_lesson_plans_bloc.dart';

abstract class GetLessonPlansState {}

class GetLessonPlansInitial extends GetLessonPlansState {}

class GetLessonPlansSuccess extends GetLessonPlansState {
  final List<LessonPlanModel> lessonPlans;
  GetLessonPlansSuccess({required this.lessonPlans});
}

class GetLessonPlansLoading extends GetLessonPlansState {}

class GetLessonPlansError extends GetLessonPlansState {
  final String message;
  GetLessonPlansError({required this.message});
}
