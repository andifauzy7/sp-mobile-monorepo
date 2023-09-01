part of 'add_lesson_plan_bloc.dart';

class AddLessonPlanEvent {
  final String? lessonPlanId;
  final String studentId;
  final DateTime datePlan;
  final String lessonId;
  final List<ActivityModel> activityId;

  AddLessonPlanEvent({
    this.lessonPlanId,
    required this.studentId,
    required this.datePlan,
    required this.lessonId,
    required this.activityId,
  });
}
