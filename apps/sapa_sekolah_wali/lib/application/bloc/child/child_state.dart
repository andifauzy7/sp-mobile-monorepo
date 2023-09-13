part of 'child_bloc.dart';

@freezed
class ChildState with _$ChildState {
  const factory ChildState.initial() = _Initial;
  const factory ChildState.loading() = _Loading;
  const factory ChildState.failure(String message) = _Failure;
  const factory ChildState.success(List<ChildModel> payload) = _Succcess;
}
