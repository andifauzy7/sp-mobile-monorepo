class NewsModel {
  NewsModel({
    this.id,
    this.newsImage,
    this.newsTitle,
    this.news,
  });

  final int? id;
  final String? newsImage;
  final String? newsTitle;
  final String? news;

  static NewsModel fromJson(Map<String?, dynamic> json) => NewsModel(
        id: json["id"],
        newsImage: json["news_image"],
        newsTitle: json["news_title"],
        news: json["news"],
      );
}
