part of 'delete_monthly_report_bloc.dart';

abstract class DeleteMonthlyReportState {}

final class DeleteMonthlyReportInitial extends DeleteMonthlyReportState {}

class DeleteMonthlyReportSuccess extends DeleteMonthlyReportState {}

class DeleteMonthlyReportLoading extends DeleteMonthlyReportState {}

class DeleteMonthlyReportError extends DeleteMonthlyReportState {
  final String message;
  DeleteMonthlyReportError({required this.message});
}
