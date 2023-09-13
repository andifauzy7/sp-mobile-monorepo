import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_guru/model/teacher_response_model.dart';
import 'package:sapa_sekolah_guru/repositories/auth_repository.dart';

part 'get_teacher_event.dart';
part 'get_teacher_state.dart';

@injectable
class GetTeacherBloc extends Bloc<GetTeacherEvent, GetTeacherState> {
  final AuthRepository authRepository;
  GetTeacherBloc({
    required this.authRepository,
  }) : super(GetTeacherInitial()) {
    on<GetTeacherEvent>((event, emit) async {
      emit(GetTeacherLoading());
      final result = await authRepository.getTeacher();
      result.fold(
        (failure) => emit(GetTeacherError(
          message: failure.toString(),
        )),
        (teacher) => emit(GetTeacherSuccess(
          teacher: teacher,
        )),
      );
    });
  }
}
