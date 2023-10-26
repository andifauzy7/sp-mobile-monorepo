class MonthlyReportsResponseModel {
  bool? success;
  String? message;
  List<MonthlyReportModel>? data;

  MonthlyReportsResponseModel({this.success, this.message, this.data});

  MonthlyReportsResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <MonthlyReportModel>[];
      json['data'].forEach((v) {
        data!.add(MonthlyReportModel.fromJson(v));
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

class MonthlyReportModel {
  int? reportMonthlyId;
  String? reportDate;
  int? studentId;

  MonthlyReportModel({this.reportMonthlyId, this.reportDate, this.studentId});

  MonthlyReportModel.fromJson(Map<String, dynamic> json) {
    reportMonthlyId = json['report_monthly_id'];
    reportDate = json['report_date'];
    studentId = json['student_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['report_monthly_id'] = reportMonthlyId;
    data['report_date'] = reportDate;
    data['student_id'] = studentId;
    return data;
  }
}
