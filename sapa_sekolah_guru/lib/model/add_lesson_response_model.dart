class AddLessonResponseModel {
  bool? success;
  String? message;

  AddLessonResponseModel({this.success, this.message});

  AddLessonResponseModel.fromJson(Map<String, dynamic> json) {
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
