part of 'get_consultation_detail_bloc.dart';

abstract class GetConsultationDetailState {}

final class GetConsultationDetailInitial extends GetConsultationDetailState {}

class GetConsultationDetailSuccess extends GetConsultationDetailState {
  final ConsultationDetailModel consultation;
  GetConsultationDetailSuccess({required this.consultation});
}

class GetConsultationDetailLoading extends GetConsultationDetailState {}

class GetConsultationDetailError extends GetConsultationDetailState {
  final String message;
  GetConsultationDetailError({required this.message});
}
