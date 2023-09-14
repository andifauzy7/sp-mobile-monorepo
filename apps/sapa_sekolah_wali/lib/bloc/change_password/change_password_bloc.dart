import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_wali/repositories/auth_repository.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

@injectable
class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final AuthRepository authRepository;
  ChangePasswordBloc({
    required this.authRepository,
  }) : super(ChangePasswordInitial()) {
    on<ChangePasswordEvent>((event, emit) async {
      emit(ChangePasswordLoading());
      final result = await authRepository.changePassword(
        event.oldPassword,
        event.newPassword,
      );
      result.fold(
        (failure) => emit(ChangePasswordError(
          message: failure.toString(),
        )),
        (_) => emit(ChangePasswordSuccess()),
      );
    });
  }
}
