part of 'add_monthly_report_response_bloc.dart';

abstract class AddMonthlyReportResponseState {}

final class AddMonthlyReportResponseInitial
    extends AddMonthlyReportResponseState {}

class AddMonthlyReportResponseSuccess extends AddMonthlyReportResponseState {}

class AddMonthlyReportResponseLoading extends AddMonthlyReportResponseState {}

class AddMonthlyReportResponseError extends AddMonthlyReportResponseState {
  final String message;
  AddMonthlyReportResponseError({required this.message});
}
