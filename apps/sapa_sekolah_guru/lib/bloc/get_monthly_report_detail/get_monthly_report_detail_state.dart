part of 'get_monthly_report_detail_bloc.dart';

abstract class GetMonthlyReportDetailState {}

final class GetMonthlyReportDetailInitial extends GetMonthlyReportDetailState {}

class GetMonthlyReportDetailSuccess extends GetMonthlyReportDetailState {
  final MonthlyReportDetailModel report;
  GetMonthlyReportDetailSuccess({required this.report});
}

class GetMonthlyReportDetailLoading extends GetMonthlyReportDetailState {}

class GetMonthlyReportDetailError extends GetMonthlyReportDetailState {
  final String message;
  GetMonthlyReportDetailError({required this.message});
}
