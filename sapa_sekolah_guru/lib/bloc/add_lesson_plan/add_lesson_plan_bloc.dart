import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:sapa_sekolah_guru/model/activities_response_model.dart';
import 'package:sapa_sekolah_guru/repositories/lesson_repository.dart';

part 'add_lesson_plan_event.dart';
part 'add_lesson_plan_state.dart';

@injectable
class AddLessonPlanBloc extends Bloc<AddLessonPlanEvent, AddLessonPlanState> {
  final LessonRepository lessonRepository;
  AddLessonPlanBloc({
    required this.lessonRepository,
  }) : super(AddLessonPlanInitial()) {
    on<AddLessonPlanEvent>((event, emit) async {
      emit(AddLessonPlanLoading());
      final result = await lessonRepository.addLessonPlan(
        '',
        event.studentId,
        DateFormat("yyyy-MM-dd").format(event.datePlan),
        event.lessonId,
        event.activityId.map((e) => e.activityId.toString()).toList(),
      );
      result.fold(
        (failure) => emit(AddLessonPlanError(
          message: failure.toString(),
        )),
        (_) => emit(AddLessonPlanSuccess()),
      );
    });
  }
}
