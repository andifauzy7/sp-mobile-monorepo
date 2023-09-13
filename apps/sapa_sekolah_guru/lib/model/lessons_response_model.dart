class LessonsResponseModel {
  bool? success;
  String? message;
  List<LessonModel>? data;

  LessonsResponseModel({this.success, this.message, this.data});

  LessonsResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <LessonModel>[];
      json['data'].forEach((v) {
        data!.add(LessonModel.fromJson(v));
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

class LessonModel {
  int? subjectId;
  String? subjectName;

  LessonModel({this.subjectId, this.subjectName});

  LessonModel.fromJson(Map<String, dynamic> json) {
    subjectId = json['subject_id'];
    subjectName = json['subject_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subject_id'] = subjectId;
    data['subject_name'] = subjectName;
    return data;
  }
}
