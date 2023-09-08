import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sapa_sekolah_wali/model/teacher/teacher_model.dart';
import 'package:sapa_sekolah_wali/repositories/teacher/teacher_repository.dart';

part 'teacher_event.dart';
part 'teacher_state.dart';
part 'teacher_bloc.freezed.dart';

@injectable
class TeacherBloc extends Bloc<TeacherEvent, TeacherState> {
  TeacherRepository repository;
  TeacherBloc(this.repository) : super(const _Initial()) {
    on<TeacherEvent>((event, emit) async {
      await event.map(
        started: (_) {},
        load: (_) async {
          emit(const TeacherState.loading());

          final result = await repository.getListTeacher();

          result.fold(
            (l) {
              emit(TeacherState.failure(l.message));
            },
            (r) {
              emit(TeacherState.success(r));
            },
          );
        },
      );
    });
  }
}
