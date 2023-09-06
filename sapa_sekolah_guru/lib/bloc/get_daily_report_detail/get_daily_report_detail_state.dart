part of 'get_daily_report_detail_bloc.dart';

abstract class GetDailyReportDetailState {}

class GetDailyReportDetailInitial extends GetDailyReportDetailState {}

class GetDailyReportDetailSuccess extends GetDailyReportDetailState {
  final DailyReportDetailModel report;
  GetDailyReportDetailSuccess({required this.report});
}

class GetDailyReportDetailLoading extends GetDailyReportDetailState {}

class GetDailyReportDetailError extends GetDailyReportDetailState {
  final String message;
  GetDailyReportDetailError({required this.message});
}
