import 'package:dartz/dartz.dart';
import 'package:sapa_sekolah_wali/model/base_model.dart';

import '../../model/exception_model.dart';

abstract class AuthRepository {
  Future<Either<ExceptionModel, BaseModel>> login(String username, String password);
  Future<Either<ExceptionModel, BaseModel>> changePassword(Map<String, dynamic> payload);
}
