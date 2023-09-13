part of 'news_bloc.dart';

@freezed
class NewsState with _$NewsState {
  const factory NewsState.initial() = _Initial;
  const factory NewsState.loading() = _Loading;
  const factory NewsState.failure(String message) = _Failure;
  const factory NewsState.succcess(List<NewsModel> payload) = _Succcess;
}
