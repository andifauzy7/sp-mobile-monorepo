part of 'add_consultation_response_bloc.dart';

abstract class AddConsultationResponseState {}

final class AddConsultationResponseInitial
    extends AddConsultationResponseState {}

class AddConsultationResponseSuccess extends AddConsultationResponseState {}

class AddConsultationResponseLoading extends AddConsultationResponseState {}

class AddConsultationResponseError extends AddConsultationResponseState {
  final String message;
  AddConsultationResponseError({required this.message});
}
