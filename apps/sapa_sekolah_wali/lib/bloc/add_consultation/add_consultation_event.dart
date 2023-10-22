part of 'add_consultation_bloc.dart';

class AddConsultationEvent {
  final String studentId;
  final String teacherId;
  final String questionText;

  AddConsultationEvent({
    required this.studentId,
    required this.teacherId,
    required this.questionText,
  });
}
