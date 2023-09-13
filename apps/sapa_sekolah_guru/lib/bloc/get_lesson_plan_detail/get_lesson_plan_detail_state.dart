part of 'get_lesson_plan_detail_bloc.dart';

abstract class GetLessonPlanDetailState {}

class GetLessonPlanDetailInitial extends GetLessonPlanDetailState {}

class GetLessonPlanDetailSuccess extends GetLessonPlanDetailState {
  final LessonPlanDetailModel lessonPlan;
  GetLessonPlanDetailSuccess({required this.lessonPlan});
}

class GetLessonPlanDetailLoading extends GetLessonPlanDetailState {}

class GetLessonPlanDetailError extends GetLessonPlanDetailState {
  final String message;
  GetLessonPlanDetailError({required this.message});
}
