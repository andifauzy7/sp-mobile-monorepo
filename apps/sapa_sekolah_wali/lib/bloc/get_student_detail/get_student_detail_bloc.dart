import 'package:flutter/material.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_wali/model/student_detail_response_model.dart';
import 'package:sapa_sekolah_wali/repositories/student_repository.dart';

part 'get_student_detail_event.dart';
part 'get_student_detail_state.dart';

@injectable
class GetStudentDetailBloc
    extends Bloc<GetStudentDetailEvent, GetStudentDetailState> {
  final StudentRepository studentRepository;
  GetStudentDetailBloc({
    required this.studentRepository,
  }) : super(GetStudentDetailInitial()) {
    on<GetStudentDetailEvent>((event, emit) async {
      emit(GetStudentDetailLoading());
      final result = await studentRepository.getDetailChild(
        event.studentId,
      );
      result.fold(
        (failure) => emit(GetStudentDetailError(
          message: failure.toString(),
        )),
        (studentDetail) => emit(GetStudentDetailSuccess(
          studentDetail: studentDetail,
        )),
      );
    });
  }
}
