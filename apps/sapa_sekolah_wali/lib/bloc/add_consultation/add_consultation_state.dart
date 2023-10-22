part of 'add_consultation_bloc.dart';

abstract class AddConsultationState {}

class AddConsultationInitial extends AddConsultationState {}

class AddConsultationSuccess extends AddConsultationState {}

class AddConsultationLoading extends AddConsultationState {}

class AddConsultationError extends AddConsultationState {
  final String message;
  AddConsultationError({required this.message});
}
