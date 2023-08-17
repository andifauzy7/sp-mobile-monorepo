import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sapa_sekolah_guru/repositories/lesson_repository.dart';

part 'add_lesson_event.dart';
part 'add_lesson_state.dart';

@injectable
class AddLessonBloc extends Bloc<AddLessonEvent, AddLessonState> {
  final LessonRepository lessonRepository;
  AddLessonBloc({
    required this.lessonRepository,
  }) : super(AddLessonInitial()) {
    on<AddLessonEvent>((event, emit) async {
      emit(AddLessonLoading());
      final result = await lessonRepository.addLesson(event.lesson);
      result.fold(
        (failure) => emit(AddLessonError(
          message: failure.toString(),
        )),
        (_) => emit(AddLessonSuccess()),
      );
    });
  }
}
