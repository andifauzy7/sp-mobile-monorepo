part of 'get_name_bloc.dart';

abstract class GetNameState {}

class GetNameInitial extends GetNameState {}

class GetNameSuccess extends GetNameState {
  final String name;
  GetNameSuccess({required this.name});
}

class GetNameLoading extends GetNameState {}

class GetNameError extends GetNameState {
  final String message;
  GetNameError({required this.message});
}
