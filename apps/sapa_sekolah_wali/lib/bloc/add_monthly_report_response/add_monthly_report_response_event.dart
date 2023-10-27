part of 'add_monthly_report_response_bloc.dart';

class AddMonthlyReportResponseEvent {
  final String studentId;
  final String reportId;
  final String message;

  AddMonthlyReportResponseEvent({
    required this.studentId,
    required this.reportId,
    required this.message,
  });
}
