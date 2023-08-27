import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sapa_sekolah_guru/repositories/auth_repository.dart';

part 'get_name_event.dart';
part 'get_name_state.dart';

@injectable
class GetNameBloc extends Bloc<GetNameEvent, GetNameState> {
  final AuthRepository authRepository;
  GetNameBloc({required this.authRepository}) : super(GetNameInitial()) {
    on<GetNameEvent>((event, emit) async {
      emit(GetNameLoading());
      final result = await authRepository.getName();
      result.fold(
        (failure) => emit(GetNameError(
          message: failure.toString(),
        )),
        (name) => emit(GetNameSuccess(
          name: name,
        )),
      );
    });
  }
}
