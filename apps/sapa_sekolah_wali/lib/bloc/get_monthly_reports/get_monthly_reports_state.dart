part of 'get_monthly_reports_bloc.dart';

abstract class GetMonthlyReportsState {}

final class GetMonthlyReportsInitial extends GetMonthlyReportsState {}

class GetMonthlyReportsSuccess extends GetMonthlyReportsState {
  final List<MonthlyReportModel> reports;
  GetMonthlyReportsSuccess({required this.reports});
}

class GetMonthlyReportsLoading extends GetMonthlyReportsState {}

class GetMonthlyReportsError extends GetMonthlyReportsState {
  final String message;
  GetMonthlyReportsError({required this.message});
}
