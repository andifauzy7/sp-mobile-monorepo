class DailyReportsResponseModel {
  bool? success;
  String? message;
  List<DailyReportModel>? data;

  DailyReportsResponseModel({this.success, this.message, this.data});

  DailyReportsResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DailyReportModel>[];
      json['data'].forEach((v) {
        data!.add(DailyReportModel.fromJson(v));
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

class DailyReportModel {
  int? reportDailyId;
  String? reportDate;
  int? studentId;

  DailyReportModel({this.reportDailyId, this.reportDate, this.studentId});

  DailyReportModel.fromJson(Map<String, dynamic> json) {
    reportDailyId = json['report_daily_id'];
    reportDate = json['report_date'];
    studentId = json['student_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['report_daily_id'] = reportDailyId;
    data['report_date'] = reportDate;
    data['student_id'] = studentId;
    return data;
  }
}
