part of 'delete_lesson_plan_bloc.dart';

class DeleteLessonPlanEvent {
  final String lessonPlanId;
  final String subjectPlanId;

  DeleteLessonPlanEvent({
    required this.lessonPlanId,
    required this.subjectPlanId,
  });
}
