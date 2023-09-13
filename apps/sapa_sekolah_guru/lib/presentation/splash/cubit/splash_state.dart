part of 'splash_cubit.dart';

abstract class SplashState {}

class SplashInitial extends SplashState {}

class SplashSuccess extends SplashState {}

class SplashLoading extends SplashState {}

class SplashError extends SplashState {
  final String message;
  SplashError({required this.message});
}
