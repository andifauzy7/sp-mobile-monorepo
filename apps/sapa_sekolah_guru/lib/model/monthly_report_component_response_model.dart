class MonthlyReportComponentResponseModel {
  bool? success;
  String? message;
  List<MonthlyReportComponentModel>? data;

  MonthlyReportComponentResponseModel({this.success, this.message, this.data});

  MonthlyReportComponentResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <MonthlyReportComponentModel>[];
      json['data'].forEach((v) {
        data!.add(MonthlyReportComponentModel.fromJson(v));
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

class MonthlyReportComponentModel {
  int? cfgreportMonthlyId;
  String? reportMonthlyCode;
  String? reportMonthlyDetail;

  MonthlyReportComponentModel(
      {this.cfgreportMonthlyId,
      this.reportMonthlyCode,
      this.reportMonthlyDetail});

  MonthlyReportComponentModel.fromJson(Map<String, dynamic> json) {
    cfgreportMonthlyId = json['cfgreport_monthly_id'];
    reportMonthlyCode = json['report_monthly_code'];
    reportMonthlyDetail = json['report_monthly_detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cfgreport_monthly_id'] = cfgreportMonthlyId;
    data['report_monthly_code'] = reportMonthlyCode;
    data['report_monthly_detail'] = reportMonthlyDetail;
    return data;
  }
}
