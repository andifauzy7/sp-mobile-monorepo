part of 'add_activity_bloc.dart';

abstract class AddActivityState {}

class AddActivityInitial extends AddActivityState {}

class AddActivitySuccess extends AddActivityState {}

class AddActivityLoading extends AddActivityState {}

class AddActivityError extends AddActivityState {
  final String message;
  AddActivityError({required this.message});
}
