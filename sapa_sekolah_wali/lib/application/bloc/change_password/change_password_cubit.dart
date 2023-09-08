import 'package:bloc/bloc.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sapa_sekolah_wali/repositories/auth/auth_repository.dart';

part 'change_password_state.dart';
part 'change_password_cubit.freezed.dart';

@injectable
class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  AuthRepository repository;
  final esp = EncryptedSharedPreferences();

  ChangePasswordCubit(this.repository)
      : super(const ChangePasswordState.initial());

  Future<void> changePassword(Map<String, dynamic> data) async {
    final sp = await esp.getInstance();
    final token = sp.getString('token');

    data['token'] = token;

    final response = await repository.changePassword(data);

    response.fold(
      (l) {
        emit(ChangePasswordState.failure(l.message));
      },
      (r) {
        emit(const ChangePasswordState.success());
      },
    );
  }
}
