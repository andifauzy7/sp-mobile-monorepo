import 'package:dartz/dartz.dart';
import 'package:sapa_sekolah_wali/model/exception_model.dart';
import 'package:sapa_sekolah_wali/model/teacher/teacher_model.dart';

abstract class TeacherRepository {
  Future<Either<ExceptionModel, List<TeacherModel>>> getListTeacher();
}
