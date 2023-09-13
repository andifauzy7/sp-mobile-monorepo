part of 'detail_child_bloc.dart';

@freezed
class DetailChildState with _$DetailChildState {
  const factory DetailChildState.initial() = _Initial;
  const factory DetailChildState.loading() = _Loading;
  const factory DetailChildState.failure(String message) = _Failure;
  const factory DetailChildState.success(DetailChildModel payload) = _Success;
}
