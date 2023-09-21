part of 'get_daily_reports_bloc.dart';

abstract class GetDailyReportsState {}

class GetDailyReportsInitial extends GetDailyReportsState {}

class GetDailyReportsSuccess extends GetDailyReportsState {
  final List<DailyReportModel> reports;
  GetDailyReportsSuccess({required this.reports});
}

class GetDailyReportsLoading extends GetDailyReportsState {}

class GetDailyReportsError extends GetDailyReportsState {
  final String message;
  GetDailyReportsError({required this.message});
}
