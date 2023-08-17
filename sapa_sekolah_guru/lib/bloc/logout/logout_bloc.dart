import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sapa_sekolah_guru/repositories/auth_repository.dart';

part 'logout_event.dart';
part 'logout_state.dart';

@injectable
class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final AuthRepository authRepository;
  LogoutBloc({
    required this.authRepository,
  }) : super(LogoutInitial()) {
    on<LogoutEvent>((event, emit) async {
      emit(LogoutLoading());
      final resultLogin = await authRepository.logout();
      resultLogin.fold(
        (failure) => emit(LogoutError(
          message: failure.toString(),
        )),
        (_) => emit(LogoutSuccess()),
      );
    });
  }
}
