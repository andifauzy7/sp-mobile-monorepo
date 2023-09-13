import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_guru/repositories/lesson_repository.dart';

part 'add_activity_event.dart';
part 'add_activity_state.dart';

@injectable
class AddActivityBloc extends Bloc<AddActivityEvent, AddActivityState> {
  final LessonRepository lessonRepository;
  AddActivityBloc({
    required this.lessonRepository,
  }) : super(AddActivityInitial()) {
    on<AddActivityEvent>((event, emit) async {
      emit(AddActivityLoading());
      final result = await lessonRepository.addActivity(event.activity);
      result.fold(
        (failure) => emit(AddActivityError(
          message: failure.toString(),
        )),
        (_) => emit(AddActivitySuccess()),
      );
    });
  }
}
