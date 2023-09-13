class StudentPermitsResponseModel {
  bool? success;
  String? message;
  List<StudentPermitModel>? data;

  StudentPermitsResponseModel({this.success, this.message, this.data});

  StudentPermitsResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <StudentPermitModel>[];
      json['data'].forEach((v) {
        data!.add(StudentPermitModel.fromJson(v));
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

class StudentPermitModel {
  int? studentId;
  String? studentName;
  String? startDate;
  String? endDate;
  String? studentLeaveName;

  StudentPermitModel(
      {this.studentId,
      this.studentName,
      this.startDate,
      this.endDate,
      this.studentLeaveName});

  StudentPermitModel.fromJson(Map<String, dynamic> json) {
    studentId = json['student_id'];
    studentName = json['student_name'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    studentLeaveName = json['student_leave_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['student_id'] = studentId;
    data['student_name'] = studentName;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['student_leave_name'] = studentLeaveName;
    return data;
  }
}
