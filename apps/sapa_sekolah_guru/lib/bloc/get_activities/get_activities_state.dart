part of 'get_activities_bloc.dart';

abstract class GetActivitiesState {}

class GetActivitiesInitial extends GetActivitiesState {}

class GetActivitiesSuccess extends GetActivitiesState {
  final List<ActivityModel> activities;
  GetActivitiesSuccess({required this.activities});
}

class GetActivitiesLoading extends GetActivitiesState {}

class GetActivitiesError extends GetActivitiesState {
  final String message;
  GetActivitiesError({required this.message});
}
