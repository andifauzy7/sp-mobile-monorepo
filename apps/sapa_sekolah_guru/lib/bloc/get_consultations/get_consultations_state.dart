part of 'get_consultations_bloc.dart';

abstract class GetConsultationsState {}

final class GetConsultationsInitial extends GetConsultationsState {}

class GetConsultationsSuccess extends GetConsultationsState {
  final List<ConsultationModel> consultations;
  GetConsultationsSuccess({required this.consultations});
}

class GetConsultationsLoading extends GetConsultationsState {}

class GetConsultationsError extends GetConsultationsState {
  final String message;
  GetConsultationsError({required this.message});
}
