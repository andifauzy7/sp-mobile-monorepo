import 'package:dartz/dartz.dart';
import 'package:sapa_sekolah_wali/model/child/child_model.dart';
import 'package:sapa_sekolah_wali/model/child/detail_child_model.dart';
import 'package:sapa_sekolah_wali/model/exception_model.dart';

abstract class ChildRepository {
  Future<Either<ExceptionModel, List<ChildModel>>> getListChild();
  Future<Either<ExceptionModel, DetailChildModel>> getDetailChild(
      int studentId);
}
