part of 'update_daily_report_bloc.dart';

abstract class UpdateDailyReportState {}

class UpdateDailyReportInitial extends UpdateDailyReportState {}

class UpdateDailyReportSuccess extends UpdateDailyReportState {}

class UpdateDailyReportLoading extends UpdateDailyReportState {}

class UpdateDailyReportError extends UpdateDailyReportState {
  final String message;
  UpdateDailyReportError({required this.message});
}
