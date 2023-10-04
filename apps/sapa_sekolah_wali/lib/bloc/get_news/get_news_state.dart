part of 'get_news_bloc.dart';

@immutable
sealed class GetNewsState {}

final class GetNewsInitial extends GetNewsState {}

class GetNewsSuccess extends GetNewsState {
  final List<NewsModel> news;
  GetNewsSuccess({required this.news});
}

class GetNewsLoading extends GetNewsState {}

class GetNewsError extends GetNewsState {
  final String message;
  GetNewsError({required this.message});
}
