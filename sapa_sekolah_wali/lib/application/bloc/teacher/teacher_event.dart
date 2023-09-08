part of 'teacher_bloc.dart';

@freezed
class TeacherEvent with _$TeacherEvent {
  const factory TeacherEvent.started() = _Started;
  const factory TeacherEvent.load() = _Load;
}
