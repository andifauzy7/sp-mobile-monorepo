class ConsultationDetailResponseModel {
  bool? success;
  String? message;
  ConsultationDetailModel? data;

  ConsultationDetailResponseModel({this.success, this.message, this.data});

  ConsultationDetailResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? ConsultationDetailModel.fromJson(json['data'])
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

class ConsultationDetailModel {
  int? consultationId;
  String? studentName;
  String? teacherName;
  String? questionDate;
  String? questionText;
  List<ResponseModel>? reponseDetail;

  ConsultationDetailModel(
      {this.consultationId,
      this.studentName,
      this.teacherName,
      this.questionDate,
      this.questionText,
      this.reponseDetail});

  ConsultationDetailModel.fromJson(Map<String, dynamic> json) {
    consultationId = json['consultation_id'];
    studentName = json['student_name'];
    teacherName = json['teacher_name'];
    questionDate = json['question_date'];
    questionText = json['question_text'];
    if (json['reponse_detail'] != null) {
      reponseDetail = <ResponseModel>[];
      json['reponse_detail'].forEach((v) {
        reponseDetail!.add(ResponseModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['consultation_id'] = consultationId;
    data['student_name'] = studentName;
    data['teacher_name'] = teacherName;
    data['question_date'] = questionDate;
    data['question_text'] = questionText;
    if (reponseDetail != null) {
      data['reponse_detail'] = reponseDetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResponseModel {
  int? consultationResponseId;
  String? responseText;
  String? responseFrom;
  String? submitDate;

  ResponseModel(
      {this.consultationResponseId,
      this.responseText,
      this.responseFrom,
      this.submitDate});

  ResponseModel.fromJson(Map<String, dynamic> json) {
    consultationResponseId = json['consultation_response_id'];
    responseText = json['response_text'];
    responseFrom = json['response_from'];
    submitDate = json['submit_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['consultation_response_id'] = consultationResponseId;
    data['response_text'] = responseText;
    data['response_from'] = responseFrom;
    data['submit_date'] = submitDate;
    return data;
  }
}
