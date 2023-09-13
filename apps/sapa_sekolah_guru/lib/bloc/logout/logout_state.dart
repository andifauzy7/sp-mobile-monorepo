part of 'logout_bloc.dart';

abstract class LogoutState {}

class LogoutInitial extends LogoutState {}

class LogoutSuccess extends LogoutState {}

class LogoutLoading extends LogoutState {}

class LogoutError extends LogoutState {
  final String message;
  LogoutError({required this.message});
}
