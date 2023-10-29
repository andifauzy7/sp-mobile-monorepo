part of 'get_monthly_report_component_bloc.dart';

abstract class GetMonthlyReportComponentState {}

final class GetMonthlyReportComponentInitial
    extends GetMonthlyReportComponentState {}

class GetMonthlyReportComponentSuccess extends GetMonthlyReportComponentState {
  final List<MonthlyReportComponentModel> components;
  GetMonthlyReportComponentSuccess({required this.components});
}

class GetMonthlyReportComponentLoading extends GetMonthlyReportComponentState {}

class GetMonthlyReportComponentError extends GetMonthlyReportComponentState {
  final String message;
  GetMonthlyReportComponentError({required this.message});
}
