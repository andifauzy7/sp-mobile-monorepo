import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_guru/model/lesson_plan_detail_response_model.dart';
import 'package:sapa_sekolah_guru/repositories/lesson_repository.dart';

part 'get_lesson_plan_detail_event.dart';
part 'get_lesson_plan_detail_state.dart';

@injectable
class GetLessonPlanDetailBloc
    extends Bloc<GetLessonPlanDetailEvent, GetLessonPlanDetailState> {
  final LessonRepository lessonRepository;
  GetLessonPlanDetailBloc({
    required this.lessonRepository,
  }) : super(GetLessonPlanDetailInitial()) {
    on<GetLessonPlanDetailEvent>((event, emit) async {
      emit(GetLessonPlanDetailLoading());
      final result = await lessonRepository.getLessonPlanDetail(event.id);
      result.fold(
        (failure) => emit(GetLessonPlanDetailError(
          message: failure.toString(),
        )),
        (lessonPlans) => emit(GetLessonPlanDetailSuccess(
          lessonPlan: lessonPlans,
        )),
      );
    });
  }
}
