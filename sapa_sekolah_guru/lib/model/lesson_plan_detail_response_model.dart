class LessonPlanDetailResponseModel {
  bool? success;
  String? message;
  LessonPlanDetailModel? data;

  LessonPlanDetailResponseModel({this.success, this.message, this.data});

  LessonPlanDetailResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? LessonPlanDetailModel.fromJson(json['data'])
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

class LessonPlanDetailModel {
  int? lessonplanId;
  String? studentName;
  String? lessonplanDate;
  List<LessonPlanDataModel>? lessonPlanlesson;

  LessonPlanDetailModel(
      {this.lessonplanId,
      this.studentName,
      this.lessonplanDate,
      this.lessonPlanlesson});

  LessonPlanDetailModel.fromJson(Map<String, dynamic> json) {
    lessonplanId = json['lessonplan_id'];
    studentName = json['student_name'];
    lessonplanDate = json['lessonplan_date'];
    if (json['lesson_planlesson'] != null) {
      lessonPlanlesson = <LessonPlanDataModel>[];
      json['lesson_planlesson'].forEach((v) {
        lessonPlanlesson!.add(LessonPlanDataModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lessonplan_id'] = lessonplanId;
    data['student_name'] = studentName;
    data['lessonplan_date'] = lessonplanDate;
    if (lessonPlanlesson != null) {
      data['lesson_planlesson'] =
          lessonPlanlesson!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LessonPlanDataModel {
  int? subjectplanId;
  String? subjectName;
  List<LessonPlanActivityModel>? activityList;

  LessonPlanDataModel(
      {this.subjectplanId, this.subjectName, this.activityList});

  LessonPlanDataModel.fromJson(Map<String, dynamic> json) {
    subjectplanId = json['subjectplan_id'];
    subjectName = json['subject_name'];
    if (json['activity_list'] != null) {
      activityList = <LessonPlanActivityModel>[];
      json['activity_list'].forEach((v) {
        activityList!.add(LessonPlanActivityModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subjectplan_id'] = subjectplanId;
    data['subject_name'] = subjectName;
    if (activityList != null) {
      data['activity_list'] = activityList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LessonPlanActivityModel {
  String? activityName;

  LessonPlanActivityModel({this.activityName});

  LessonPlanActivityModel.fromJson(Map<String, dynamic> json) {
    activityName = json['activity_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['activity_name'] = activityName;
    return data;
  }
}
