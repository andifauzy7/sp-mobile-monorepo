class ActivitiesResponseModel {
  bool? success;
  String? message;
  List<ActivityModel>? data;

  ActivitiesResponseModel({this.success, this.message, this.data});

  ActivitiesResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ActivityModel>[];
      json['data'].forEach((v) {
        data!.add(ActivityModel.fromJson(v));
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

class ActivityModel {
  int? activityId;
  String? activityName;

  ActivityModel({this.activityId, this.activityName});

  ActivityModel.fromJson(Map<String, dynamic> json) {
    activityId = json['activity_id'];
    activityName = json['activity_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['activity_id'] = activityId;
    data['activity_name'] = activityName;
    return data;
  }
}
