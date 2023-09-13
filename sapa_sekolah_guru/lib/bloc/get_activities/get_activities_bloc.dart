import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_guru/model/activities_response_model.dart';
import 'package:sapa_sekolah_guru/repositories/lesson_repository.dart';

part 'get_activities_event.dart';
part 'get_activities_state.dart';

@injectable
class GetActivitiesBloc extends Bloc<GetActivitiesEvent, GetActivitiesState> {
  final LessonRepository lessonRepository;
  GetActivitiesBloc({
    required this.lessonRepository,
  }) : super(GetActivitiesInitial()) {
    on<GetActivitiesEvent>((event, emit) async {
      emit(GetActivitiesLoading());
      final result = await lessonRepository.getActivities();
      result.fold(
        (failure) => emit(GetActivitiesError(
          message: failure.toString(),
        )),
        (activities) => emit(GetActivitiesSuccess(
          activities: activities,
        )),
      );
    });
  }
}
