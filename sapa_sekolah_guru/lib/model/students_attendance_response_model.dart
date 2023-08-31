class StudentsAttendanceResponseModel {
  bool? success;
  String? message;
  List<StudentAttendanceModel>? data;

  StudentsAttendanceResponseModel({this.success, this.message, this.data});

  StudentsAttendanceResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <StudentAttendanceModel>[];
      json['data'].forEach((v) {
        data!.add(StudentAttendanceModel.fromJson(v));
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

class StudentAttendanceModel {
  int? studentId;
  String? studentName;
  bool? ispresence;

  StudentAttendanceModel({this.studentId, this.studentName, this.ispresence});

  StudentAttendanceModel.fromJson(Map<String, dynamic> json) {
    studentId = json['student_id'];
    studentName = json['student_name'];
    ispresence = json['ispresence'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['student_id'] = studentId;
    data['student_name'] = studentName;
    data['ispresence'] = ispresence;
    return data;
  }
}
