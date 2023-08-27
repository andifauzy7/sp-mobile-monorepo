class StudentsResponseModel {
  bool? success;
  String? message;
  List<StudentModel>? data;

  StudentsResponseModel({this.success, this.message, this.data});

  StudentsResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <StudentModel>[];
      json['data'].forEach((v) {
        data!.add(StudentModel.fromJson(v));
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

class StudentModel {
  int? studentId;
  String? studentName;

  StudentModel({this.studentId, this.studentName});

  StudentModel.fromJson(Map<String, dynamic> json) {
    studentId = json['student_id'];
    studentName = json['student_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['student_id'] = studentId;
    data['student_name'] = studentName;
    return data;
  }
}
