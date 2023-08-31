part of 'add_lesson_plan_bloc.dart';

class AddLessonPlanEvent {
  final String studentId;
  final DateTime datePlan;
  final String lessonId;
  final List<ActivityModel> activityId;

  AddLessonPlanEvent({
    required this.studentId,
    required this.datePlan,
    required this.lessonId,
    required this.activityId,
  });
}
