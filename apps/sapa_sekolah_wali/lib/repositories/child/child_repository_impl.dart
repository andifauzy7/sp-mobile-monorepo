import 'package:dio/dio.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:injectable/injectable.dart';
import 'package:sapa_sekolah_wali/model/child/detail_child_model.dart';
import 'package:sapa_sekolah_wali/model/exception_model.dart';
import 'package:dartz/dartz.dart';
import 'package:sapa_sekolah_wali/repositories/child/child_repository.dart';
import 'package:sapa_sekolah_wali/repositories/utils/api_path.dart';

@LazySingleton(as: ChildRepository)
class ChildRepositoryImpl implements ChildRepository {
  Dio dio;
  final esp = EncryptedSharedPreferences();

  ChildRepositoryImpl(this.dio);

  @override
  Future<Either<ExceptionModel, DetailChildModel>> getDetailChild(
      int studentId) async {
    final sp = await esp.getInstance();
    final token = sp.getString('token');
    final userId = sp.getString('user_id');

    final formData = FormData.fromMap({
      "token": token,
      "user_id": userId,
      "student_id": studentId,
    });

    try {
      final response = await dio.post(ApiPath.DETAIL_CHILD, data: formData);
      final result = DetailChildModel.fromJson(response.data['data'][0]);
      return Right(result);
    } catch (e) {
      return Left(ExceptionModel(e.toString()));
    }
  }
}
