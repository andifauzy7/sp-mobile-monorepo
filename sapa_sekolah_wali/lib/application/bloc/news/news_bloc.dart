import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sapa_sekolah_wali/repositories/news/news_repository.dart';

import '../../../model/news/news_model.dart';

part 'news_event.dart';
part 'news_state.dart';
part 'news_bloc.freezed.dart';

@injectable
class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsRepository repository;

  NewsBloc(this.repository) : super(const _Initial()) {
    on<NewsEvent>((event, emit) async {
      await event.map(
        started: (started) {},
        load: (load) async {
          final response = await repository.getAllNews();
          response.fold(
            (l) {
              emit(NewsState.failure(l.message));
            },
            (r) {
              emit(NewsState.succcess(r));
            },
          );
        },
      );
    });
  }
}
