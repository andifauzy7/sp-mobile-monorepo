import 'package:flutter/material.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_wali/model/teacher_detail_response_model.dart';
import 'package:sapa_sekolah_wali/repositories/teacher_repository.dart';

part 'get_teacher_detail_event.dart';
part 'get_teacher_detail_state.dart';

@injectable
class GetTeacherDetailBloc
    extends Bloc<GetTeacherDetailEvent, GetTeacherDetailState> {
  final TeacherRepository teacherRepository;
  GetTeacherDetailBloc({
    required this.teacherRepository,
  }) : super(GetTeacherDetailInitial()) {
    on<GetTeacherDetailEvent>((event, emit) async {
      emit(GetTeacherDetailLoading());
      final result = await teacherRepository.getDetailTeacher(
        event.teacherId,
      );
      result.fold(
        (failure) => emit(GetTeacherDetailError(
          message: failure.toString(),
        )),
        (teacherDetail) => emit(GetTeacherDetailSuccess(
          teacherDetail: teacherDetail,
        )),
      );
    });
  }
}
