class LessonPlansResponseModel {
  bool? success;
  String? message;
  List<LessonPlanModel>? data;

  LessonPlansResponseModel({this.success, this.message, this.data});

  LessonPlansResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <LessonPlanModel>[];
      json['data'].forEach((v) {
        data!.add(LessonPlanModel.fromJson(v));
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

class LessonPlanModel {
  int? lessonplanId;
  String? studentName;
  String? lessonplanDate;
  List<Lesson>? lessonList;

  LessonPlanModel(
      {this.lessonplanId,
      this.studentName,
      this.lessonplanDate,
      this.lessonList});

  LessonPlanModel.fromJson(Map<String, dynamic> json) {
    lessonplanId = json['lessonplan_id'];
    studentName = json['student_name'];
    lessonplanDate = json['lessonplan_date'];
    if (json['lesson_list'] != null) {
      lessonList = <Lesson>[];
      json['lesson_list'].forEach((v) {
        lessonList!.add(Lesson.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lessonplan_id'] = lessonplanId;
    data['student_name'] = studentName;
    data['lessonplan_date'] = lessonplanDate;
    if (lessonList != null) {
      data['lesson_list'] = lessonList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Lesson {
  String? subjectName;

  Lesson({this.subjectName});

  Lesson.fromJson(Map<String, dynamic> json) {
    subjectName = json['subject_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subject_name'] = subjectName;
    return data;
  }
}
