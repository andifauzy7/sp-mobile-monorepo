import 'package:dartz/dartz.dart';
import 'package:sapa_sekolah_wali/model/exception_model.dart';
import 'package:sapa_sekolah_wali/model/news/news_model.dart';

abstract class NewsRepository {
  
  Future<Either<ExceptionModel, List<NewsModel>>> getAllNews();

}