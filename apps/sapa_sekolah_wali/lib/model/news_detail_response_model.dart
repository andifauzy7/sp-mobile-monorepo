class NewsDetailResponseModel {
  bool? success;
  String? message;
  List<NewsDetailModel>? data;

  NewsDetailResponseModel({this.success, this.message, this.data});

  NewsDetailResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <NewsDetailModel>[];
      json['data'].forEach((v) {
        data!.add(NewsDetailModel.fromJson(v));
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

class NewsDetailModel {
  int? id;
  String? newsTitle;
  String? newsInfo;

  NewsDetailModel({this.id, this.newsTitle, this.newsInfo});

  NewsDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    newsTitle = json['news_title'];
    newsInfo = json['news_info'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['news_title'] = newsTitle;
    data['news_info'] = newsInfo;
    return data;
  }
}
