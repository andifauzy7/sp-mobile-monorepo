part of 'change_password_bloc.dart';

class ChangePasswordEvent {
  final String oldPassword;
  final String newPassword;

  ChangePasswordEvent({
    required this.oldPassword,
    required this.newPassword,
  });
}
