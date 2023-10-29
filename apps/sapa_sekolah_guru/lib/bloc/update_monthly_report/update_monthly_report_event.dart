part of 'update_monthly_report_bloc.dart';

class UpdateMonthlyReportEvent {
  final String? reportMonthlyId;
  final String reportDate;
  final String studentId;
  final List<Map<String, String>> reportMonthly;

  UpdateMonthlyReportEvent({
    this.reportMonthlyId,
    required this.reportDate,
    required this.studentId,
    required this.reportMonthly,
  });
}
