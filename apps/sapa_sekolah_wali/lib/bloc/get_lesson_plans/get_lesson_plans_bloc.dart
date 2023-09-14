import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_wali/model/lesson_plans_response_model.dart';
import 'package:sapa_sekolah_wali/repositories/lesson_repository.dart';

part 'get_lesson_plans_event.dart';
part 'get_lesson_plans_state.dart';

@injectable
class GetLessonPlansBloc
    extends Bloc<GetLessonPlansEvent, GetLessonPlansState> {
  final LessonRepository lessonRepository;
  GetLessonPlansBloc({
    required this.lessonRepository,
  }) : super(GetLessonPlansInitial()) {
    on<GetLessonPlansEvent>((event, emit) async {
      emit(GetLessonPlansLoading());
      final result = await lessonRepository.getLessonPlans(
        event.studentId,
      );
      result.fold(
        (failure) => emit(GetLessonPlansError(
          message: failure.toString(),
        )),
        (lessonPlans) => emit(GetLessonPlansSuccess(
          lessonPlans: lessonPlans.reversed.toList(),
        )),
      );
    });
  }
}
