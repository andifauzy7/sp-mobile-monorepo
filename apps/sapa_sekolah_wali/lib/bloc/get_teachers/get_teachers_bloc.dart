import 'package:flutter/material.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_wali/model/teacher/teacher_model.dart';
import 'package:sapa_sekolah_wali/repositories/teacher/teacher_repository.dart';

part 'get_teachers_event.dart';
part 'get_teachers_state.dart';

@injectable
class GetTeachersBloc extends Bloc<GetTeachersEvent, GetTeachersState> {
  final TeacherRepository teacherRepository;
  GetTeachersBloc({
    required this.teacherRepository,
  }) : super(GetTeachersInitial()) {
    on<GetTeachersEvent>((event, emit) async {
      emit(GetTeachersLoading());
      final result = await teacherRepository.getListTeacher();
      result.fold(
        (failure) => emit(GetTeachersError(
          message: failure.toString(),
        )),
        (teachers) => emit(GetTeachersSuccess(
          teachers: teachers,
        )),
      );
    });
  }
}
