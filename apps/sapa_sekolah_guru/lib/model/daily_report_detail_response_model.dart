class DailyReportDetailResponseModel {
  bool? success;
  String? message;
  List<DailyReportDetailModel>? data;

  DailyReportDetailResponseModel({this.success, this.message, this.data});

  DailyReportDetailResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DailyReportDetailModel>[];
      json['data'].forEach((v) {
        data!.add(DailyReportDetailModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DailyReportDetailModel {
  int? reportDailyId;
  int? studentId;
  String? reportDate;
  String? studentName;
  int? completeWork;
  int? qualityWork;
  int? needWork;
  int? behaviorSchool;
  int? improvement;

  DailyReportDetailModel(
      {this.reportDailyId,
      this.studentId,
      this.reportDate,
      this.studentName,
      this.completeWork,
      this.qualityWork,
      this.needWork,
      this.behaviorSchool,
      this.improvement});

  DailyReportDetailModel.fromJson(Map<String, dynamic> json) {
    reportDailyId = json['report_daily_id'];
    studentId = json['student_id'];
    reportDate = json['report_date'];
    studentName = json['student_name'];
    completeWork = json['complete_work'];
    qualityWork = json['quality_work'];
    needWork = json['need_work'];
    behaviorSchool = json['behavior_school'];
    improvement = json['improvement'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['report_daily_id'] = reportDailyId;
    data['student_id'] = studentId;
    data['report_date'] = reportDate;
    data['student_name'] = studentName;
    data['complete_work'] = completeWork;
    data['quality_work'] = qualityWork;
    data['need_work'] = needWork;
    data['behavior_school'] = behaviorSchool;
    data['improvement'] = improvement;
    return data;
  }
}
