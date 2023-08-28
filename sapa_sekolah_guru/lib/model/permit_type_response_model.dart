class PermitTypeResponseModel {
  bool? success;
  String? message;
  List<PermitTypeModel>? data;

  PermitTypeResponseModel({this.success, this.message, this.data});

  PermitTypeResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <PermitTypeModel>[];
      json['data'].forEach((v) {
        data!.add(PermitTypeModel.fromJson(v));
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

class PermitTypeModel {
  int? studentLeaveId;
  String? studentLeaveName;

  PermitTypeModel({this.studentLeaveId, this.studentLeaveName});

  PermitTypeModel.fromJson(Map<String, dynamic> json) {
    studentLeaveId = json['student_leave_id'];
    studentLeaveName = json['student_leave_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['student_leave_id'] = studentLeaveId;
    data['student_leave_name'] = studentLeaveName;
    return data;
  }
}
