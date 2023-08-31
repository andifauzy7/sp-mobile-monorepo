class AddLessonPlanResponseModel {
  bool? success;
  String? message;

  AddLessonPlanResponseModel({this.success, this.message});

  AddLessonPlanResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    return data;
  }
}
