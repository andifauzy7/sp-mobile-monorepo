part of 'add_permit_bloc.dart';

abstract class AddPermitState {}

class AddPermitInitial extends AddPermitState {}

class AddPermitSuccess extends AddPermitState {}

class AddPermitLoading extends AddPermitState {}

class AddPermitError extends AddPermitState {
  final String message;
  AddPermitError({required this.message});
}
