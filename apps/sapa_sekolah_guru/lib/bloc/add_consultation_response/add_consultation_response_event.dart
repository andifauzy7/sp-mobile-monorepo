part of 'add_consultation_response_bloc.dart';

class AddConsultationResponseEvent {
  final String consultationId;
  final String responseText;

  AddConsultationResponseEvent({
    required this.consultationId,
    required this.responseText,
  });
}
