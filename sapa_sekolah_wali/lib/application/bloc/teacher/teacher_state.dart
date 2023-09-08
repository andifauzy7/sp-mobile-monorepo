part of 'teacher_bloc.dart';

@freezed
class TeacherState with _$TeacherState {
  const factory TeacherState.initial() = _Initial;
  const factory TeacherState.loading() = _Loading;
  const factory TeacherState.failure(String message) = _Failure;
  const factory TeacherState.success(List<TeacherModel> payload) = _Succcess;
}
