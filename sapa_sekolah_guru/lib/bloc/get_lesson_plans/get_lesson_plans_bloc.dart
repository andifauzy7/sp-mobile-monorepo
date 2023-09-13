import 'package:sapa_component/sapa_component.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_guru/model/lesson_plans_response_model.dart';
import 'package:sapa_sekolah_guru/repositories/lesson_repository.dart';

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
        DateFormat("yyyy-MM-dd").format(
          event.lessonDate,
        ),
      );
      result.fold(
        (failure) => emit(GetLessonPlansError(
          message: failure.toString(),
        )),
        (lessonPlans) => emit(GetLessonPlansSuccess(
          lessonPlans: lessonPlans,
        )),
      );
    });
  }
}
