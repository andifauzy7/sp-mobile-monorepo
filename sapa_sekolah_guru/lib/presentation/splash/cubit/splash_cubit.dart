import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sapa_sekolah_guru/repositories/auth_repository.dart';

part 'splash_state.dart';

@injectable
class SplashCubit extends Cubit<SplashState> {
  final AuthRepository authRepository;
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
