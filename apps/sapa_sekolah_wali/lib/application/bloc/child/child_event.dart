part of 'child_bloc.dart';

@freezed
class ChildEvent with _$ChildEvent {
  const factory ChildEvent.started() = _Started;
  const factory ChildEvent.load() = _Load;
}