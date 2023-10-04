class NewsResponseModel {
  bool? success;
  String? message;
  List<NewsModel>? data;

  NewsResponseModel({this.success, this.message, this.data});

  NewsResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <NewsModel>[];
      json['data'].forEach((v) {
        data!.add(NewsModel.fromJson(v));
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

class NewsModel {
  int? id;
  String? newsImage;
  String? newsTitle;
  String? news;

  NewsModel({this.id, this.newsImage, this.newsTitle, this.news});

  NewsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    newsImage = json['news_image'];
    newsTitle = json['news_title'];
    news = json['news'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['news_image'] = newsImage;
    data['news_title'] = newsTitle;
    data['news'] = news;
    return data;
  }
}
