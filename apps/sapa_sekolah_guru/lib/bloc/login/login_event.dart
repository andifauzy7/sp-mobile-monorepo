part of 'login_bloc.dart';

class LoginEvent {
  final String username;
  final String password;
  const LoginEvent({
    required this.username,
    required this.password,
  });
}
