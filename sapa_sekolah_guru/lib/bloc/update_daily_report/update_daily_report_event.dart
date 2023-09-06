part of 'update_daily_report_bloc.dart';

class UpdateDailyReportEvent {
  final String reportDailyId;
  final String reportDate;
  final String studentId;
  final String completeWork;
  final String qualityWork;
  final String needToWork;
  final String behaviorSchool;
  final String improvement;

  UpdateDailyReportEvent({
    required this.reportDailyId,
    required this.reportDate,
    required this.studentId,
    required this.completeWork,
    required this.qualityWork,
    required this.needToWork,
    required this.behaviorSchool,
    required this.improvement,
  });
}
