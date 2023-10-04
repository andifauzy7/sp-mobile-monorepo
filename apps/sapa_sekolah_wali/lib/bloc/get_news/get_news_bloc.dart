import 'package:flutter/material.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_wali/model/news_response_model.dart';
import 'package:sapa_sekolah_wali/repositories/news_repository.dart';

part 'get_news_event.dart';
part 'get_news_state.dart';

@injectable
class GetNewsBloc extends Bloc<GetNewsEvent, GetNewsState> {
  final NewsRepository newsRepository;
  GetNewsBloc({
    required this.newsRepository,
  }) : super(GetNewsInitial()) {
    on<GetNewsEvent>((event, emit) async {
      emit(GetNewsLoading());
      final result = await newsRepository.getNews();
      result.fold(
        (failure) => emit(GetNewsError(
          message: failure.toString(),
        )),
        (news) => emit(GetNewsSuccess(
          news: news,
        )),
      );
    });
  }
}
