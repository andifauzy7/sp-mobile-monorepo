import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_wali/repositories/auth_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  LoginBloc({required this.authRepository}) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(LoginLoading());
      final resultLogin = await authRepository.login(
        event.username,
        event.password,
      );
      resultLogin.fold(
        (failure) => emit(LoginError(
          message: failure.toString(),
        )),
        (_) => emit(LoginSuccess()),
      );
    });
  }
}
