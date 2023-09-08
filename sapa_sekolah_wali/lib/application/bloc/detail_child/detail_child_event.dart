part of 'detail_child_bloc.dart';

@freezed
class DetailChildEvent with _$DetailChildEvent {
  const factory DetailChildEvent.started() = _Started;
  const factory DetailChildEvent.load(int studentId) = _Load;
}
