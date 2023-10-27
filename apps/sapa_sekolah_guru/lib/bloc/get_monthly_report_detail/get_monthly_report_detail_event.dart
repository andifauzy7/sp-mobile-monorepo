part of 'get_monthly_report_detail_bloc.dart';

class GetMonthlyReportDetailEvent {
  final String reportId;
  final String studentId;

  GetMonthlyReportDetailEvent({
    required this.reportId,
    required this.studentId,
  });
}
