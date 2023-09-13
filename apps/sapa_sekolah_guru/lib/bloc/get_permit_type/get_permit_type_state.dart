part of 'get_permit_type_bloc.dart';

abstract class GetPermitTypeState {}

class GetPermitTypeInitial extends GetPermitTypeState {}

class GetPermitTypeSuccess extends GetPermitTypeState {
  final List<PermitTypeModel> permit;
  GetPermitTypeSuccess({required this.permit});
}

class GetPermitTypeLoading extends GetPermitTypeState {}

class GetPermitTypeError extends GetPermitTypeState {
  final String message;
  GetPermitTypeError({required this.message});
}
