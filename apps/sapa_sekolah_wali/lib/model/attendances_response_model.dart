class AttendancesResponseModel {
  bool? success;
  String? message;
  List<AttendanceModel>? data;

  AttendancesResponseModel({this.success, this.message, this.data});

  AttendancesResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AttendanceModel>[];
      json['data'].forEach((v) {
        data!.add(AttendanceModel.fromJson(v));
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

class AttendanceModel {
  String? tanggal;
  String? status;
  String? reason;

  AttendanceModel({this.tanggal, this.status, this.reason});

  AttendanceModel.fromJson(Map<String, dynamic> json) {
    tanggal = json['tanggal'];
    status = json['status'];
    reason = json['reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tanggal'] = tanggal;
    data['status'] = status;
    data['reason'] = reason;
    return data;
  }
}
