import 'package:sapa_core/failure/failure.dart';
import 'package:sapa_core/failure/server_failure.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_wali/model/news_response_model.dart';

abstract class NewsRepository {
  Future<Either<Failure, List<NewsModel>>> getNews();
}

@LazySingleton(as: NewsRepository)
class NewsRepositoryImpl implements NewsRepository {
  final Dio dio;

  NewsRepositoryImpl({
    required this.dio,
  });

  @override
  Future<Either<Failure, List<NewsModel>>> getNews() async {
    try {
      final response = await dio.post('infolist.php');
      if (response.statusCode == 200) {
        final result = NewsResponseModel.fromJson(response.data);
        if (result.success ?? false) {
          return Right(result.data ?? []);
        } else {
          return Left(
            ServerFailure(message: result.message),
          );
        }
      } else {
        return Left(
          ServerFailure(message: response.data['message']),
        );
      }
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
