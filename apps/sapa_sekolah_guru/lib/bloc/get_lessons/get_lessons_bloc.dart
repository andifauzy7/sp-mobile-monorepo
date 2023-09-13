import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_guru/model/lessons_response_model.dart';
import 'package:sapa_sekolah_guru/repositories/lesson_repository.dart';

part 'get_lessons_event.dart';
part 'get_lessons_state.dart';

@injectable
class GetLessonsBloc extends Bloc<GetLessonsEvent, GetLessonsState> {
  final LessonRepository lessonRepository;
  GetLessonsBloc({
    required this.lessonRepository,
  }) : super(GetLessonsInitial()) {
    on<GetLessonsEvent>((event, emit) async {
      emit(GetLessonsLoading());
      final result = await lessonRepository.getLessons();
      result.fold(
        (failure) => emit(GetLessonsError(
          message: failure.toString(),
        )),
        (lessons) => emit(GetLessonsSuccess(
          lessons: lessons,
        )),
      );
    });
  }
}
