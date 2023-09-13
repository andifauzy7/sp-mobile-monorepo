class TeacherResponseModel {
  bool? success;
  String? message;
  List<TeacherModel>? data;

  TeacherResponseModel({this.success, this.message, this.data});

  TeacherResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <TeacherModel>[];
      json['data'].forEach((v) {
        data!.add(TeacherModel.fromJson(v));
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

class TeacherModel {
  int? employeeId;
  String? employeeName;
  String? employeePhoto;

  TeacherModel({this.employeeId, this.employeeName, this.employeePhoto});

  TeacherModel.fromJson(Map<String, dynamic> json) {
    employeeId = json['employee_id'];
    employeeName = json['employee_name'];
    employeePhoto = json['employee_photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['employee_id'] = employeeId;
    data['employee_name'] = employeeName;
    data['employee_photo'] = employeePhoto;
    return data;
  }
}
