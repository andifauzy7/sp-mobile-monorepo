part of 'update_monthly_report_bloc.dart';

abstract class UpdateMonthlyReportState {}

final class UpdateMonthlyReportInitial extends UpdateMonthlyReportState {}

class UpdateMonthlyReportSuccess extends UpdateMonthlyReportState {}

class UpdateMonthlyReportLoading extends UpdateMonthlyReportState {}

class UpdateMonthlyReportError extends UpdateMonthlyReportState {
  final String message;
  UpdateMonthlyReportError({required this.message});
}
