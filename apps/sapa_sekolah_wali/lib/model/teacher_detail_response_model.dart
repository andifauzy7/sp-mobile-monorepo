class TeacherDetailResponseModel {
  bool? success;
  String? message;
  TeacherDetailModel? data;

  TeacherDetailResponseModel({this.success, this.message, this.data});

  TeacherDetailResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data =
        json['data'] != null ? TeacherDetailModel.fromJson(json['data']) : null;
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

class TeacherDetailModel {
  int? employeeId;
  String? employeeName;
  String? employeePhoto;
  String? description;

  TeacherDetailModel(
      {this.employeeId,
      this.employeeName,
      this.employeePhoto,
      this.description});

  TeacherDetailModel.fromJson(Map<String, dynamic> json) {
    employeeId = json['employee_id'];
    employeeName = json['employee_name'];
    employeePhoto = json['employee_photo'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['employee_id'] = employeeId;
    data['employee_name'] = employeeName;
    data['employee_photo'] = employeePhoto;
    data['description'] = description;
    return data;
  }
}
