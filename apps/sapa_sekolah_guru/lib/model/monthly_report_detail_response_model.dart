class MonthlyReportDetailResponseModel {
  bool? success;
  String? message;
  MonthlyReportDetailModel? data;

  MonthlyReportDetailResponseModel({this.success, this.message, this.data});

  MonthlyReportDetailResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? MonthlyReportDetailModel.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class MonthlyReportDetailModel {
  int? reportMonthlyId;
  String? studentName;
  String? reportDate;
  String? parentNotes;
  List<ReportDetailModel>? reportDetail;

  MonthlyReportDetailModel(
      {this.reportMonthlyId,
      this.studentName,
      this.reportDate,
      this.parentNotes,
      this.reportDetail});

  MonthlyReportDetailModel.fromJson(Map<String, dynamic> json) {
    reportMonthlyId = json['report_monthly_id'];
    studentName = json['student_name'];
    reportDate = json['report_date'];
    parentNotes = json['parent_notes'];
    if (json['report_detail'] != null) {
      reportDetail = <ReportDetailModel>[];
      json['report_detail'].forEach((v) {
        reportDetail!.add(ReportDetailModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['report_monthly_id'] = reportMonthlyId;
    data['student_name'] = studentName;
    data['report_date'] = reportDate;
    data['parent_notes'] = parentNotes;
    if (reportDetail != null) {
      data['report_detail'] = reportDetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReportDetailModel {
  int? componentId;
  String? headerReport;
  String? reportDetail;

  ReportDetailModel({this.headerReport, this.reportDetail});

  ReportDetailModel.fromJson(Map<String, dynamic> json) {
    componentId = json['component_id'];
    headerReport = json['header_report'];
    reportDetail = json['report_detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['component_id'] = componentId;
    data['header_report'] = headerReport;
    data['report_detail'] = reportDetail;
    return data;
  }
}
