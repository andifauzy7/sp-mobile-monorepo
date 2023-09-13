import 'package:dio/dio.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:injectable/injectable.dart';
import 'package:sapa_sekolah_wali/model/exception_model.dart';
import 'package:dartz/dartz.dart';
import 'package:sapa_sekolah_wali/model/teacher/teacher_model.dart';
import 'package:sapa_sekolah_wali/repositories/teacher/teacher_repository.dart';
import 'package:sapa_sekolah_wali/repositories/utils/api_path.dart';

@LazySingleton(as: TeacherRepository)
class TeacherRepositoryImpl implements TeacherRepository {
  Dio dio;
  final esp = EncryptedSharedPreferences();

  TeacherRepositoryImpl(this.dio);

  @override
  Future<Either<ExceptionModel, List<TeacherModel>>> getListTeacher() async {
    final sp = await esp.getInstance();
    final token = sp.getString('token');
    final userId = sp.getString('user_id');

    final formData = FormData.fromMap({
      "token": token,
      "user_id": userId,
    });

    try {
      final response = await dio.post(ApiPath.TEACHER_LIST, data: formData);
      final result = (response.data['data'] as List)
          .map((e) => TeacherModel.fromMap(e))
          .toList();
      return Right(result);
    } catch (e) {
      return Left(ExceptionModel(e.toString()));
    }
  }
}
