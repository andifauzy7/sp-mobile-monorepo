import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:sapa_sekolah_wali/model/news/news_model.dart';
import 'package:sapa_sekolah_wali/model/exception_model.dart';
import 'package:sapa_sekolah_wali/repositories/news/news_repository.dart';

import '../utils/api_path.dart';

@LazySingleton(as: NewsRepository)
class NewsRepositoryImpl implements NewsRepository {
  Dio dio;

  NewsRepositoryImpl(this.dio);

  @override
  Future<Either<ExceptionModel, List<NewsModel>>> getAllNews() async {
    try {
      final response = await dio.get(ApiPath.NEWS);
      final result = (response.data['data'] as List).map((e) => NewsModel.fromJson(e)).toList();
      return Right(result);
    } catch (e) {
      return Left(ExceptionModel(e.toString()));
    }
  }
}
