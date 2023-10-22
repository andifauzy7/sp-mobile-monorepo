class ConsultationsResponseModel {
  bool? success;
  String? message;
  List<ConsultationModel>? data;

  ConsultationsResponseModel({this.success, this.message, this.data});

  ConsultationsResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ConsultationModel>[];
      json['data'].forEach((v) {
        data!.add(ConsultationModel.fromJson(v));
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

class ConsultationModel {
  int? consultationId;
  String? studentName;
  String? employeeName;
  String? questionText;
  String? submitDate;

  ConsultationModel(
      {this.consultationId,
      this.studentName,
      this.employeeName,
      this.questionText,
      this.submitDate});

  ConsultationModel.fromJson(Map<String, dynamic> json) {
    consultationId = json['consultation_id'];
    studentName = json['student_name'];
    employeeName = json['employee_name'];
    questionText = json['question_text'];
    submitDate = json['submit_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['consultation_id'] = consultationId;
    data['student_name'] = studentName;
    data['employee_name'] = employeeName;
    data['question_text'] = questionText;
    data['submit_date'] = submitDate;
    return data;
  }
}
