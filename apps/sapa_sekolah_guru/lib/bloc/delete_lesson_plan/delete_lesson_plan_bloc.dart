import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_guru/repositories/lesson_repository.dart';

part 'delete_lesson_plan_event.dart';
part 'delete_lesson_plan_state.dart';

@injectable
class DeleteLessonPlanBloc
    extends Bloc<DeleteLessonPlanEvent, DeleteLessonPlanState> {
  final LessonRepository lessonRepository;
  DeleteLessonPlanBloc({
    required this.lessonRepository,
  }) : super(DeleteLessonPlanInitial()) {
    on<DeleteLessonPlanEvent>((event, emit) async {
      emit(DeleteLessonPlanLoading());
      final result = await lessonRepository.deleteLessonPlan(
        event.lessonPlanId,
        event.subjectPlanId,
      );
      result.fold(
        (failure) => emit(DeleteLessonPlanError(
          message: failure.toString(),
        )),
        (_) => emit(DeleteLessonPlanSuccess()),
      );
    });
  }
}
