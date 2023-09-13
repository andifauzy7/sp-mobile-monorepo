import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sapa_sekolah_wali/repositories/auth/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(const _Initial()) {
    on<AuthEvent>((event, emit) async {
      await event.map(
        started: (started) {},
        login: (login) async {
          emit(const AuthState.loading());

          final response = await authRepository.login(
            login.payload['username'],
            login.payload['password'],
          );

          response.fold(
            (l) {
              emit(AuthState.failure(l.message));
            },
            (r) {
              emit(const AuthState.success());
            },
          );
        },
      );
    });
  }
}
