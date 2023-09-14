import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_wali/repositories/auth_repository.dart';

part 'splash_state.dart';

@injectable
class SplashCubit extends Cubit<SplashState> {
  final AuthRepositoryTemp authRepository;
  SplashCubit({required this.authRepository}) : super(SplashInitial());

  Future<void> checkSession() async {
    emit(SplashLoading());
    final result = await authRepository.isTokenExist();
    result.fold(
      (failure) => emit(SplashError(
        message: failure.toString(),
      )),
      (isTokenExist) => {
        if (isTokenExist)
          {emit(SplashSuccess())}
        else
          {emit(SplashError(message: ''))}
      },
    );
  }
}
