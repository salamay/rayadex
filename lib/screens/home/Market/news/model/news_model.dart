// To parse this JSON data, do
//
//     final newsModel = newsModelFromJson(jsonString);

import 'dart:convert';
import 'dart:convert' show utf8;

NewsModel newsModelFromJson(String str) => NewsModel.fromJson(json.decode(str));

String newsModelToJson(NewsModel data) => json.encode(data.toJson());

class NewsModel {
  NewsModel({
    required this.status,
    required this.totalResults,
    required this.results,
    this.nextPage,
  });

  String status;
  int totalResults;
  List<Result> results;
  String? nextPage;

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
    status: json["status"],
    totalResults: json["totalResults"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    nextPage: json["nextPage"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "totalResults": totalResults,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "nextPage": nextPage,
  };
}

class Result {
  Result({
    required this.title,
    required this.link,
    this.videoUrl,
    this.description,
    required this.content,
    required this.pubDate,
    this.imageUrl,
    this.sourceId,
    this.category,
    this.country,
    this.language,
  });

  String title;
  String link;
  List<String>? keywords;
  List<String>? creator;
  String? videoUrl;
  String? description;
  String content;
  String pubDate;
  String? imageUrl;
  String? sourceId;
  List<Category>? category;
  List<String>? country;
  String? language;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    title: utf8.decode(json["title"].codeUnits),
    link: json["link"],
    videoUrl: json["video_url"],
    description: json["description"],
    content: utf8.decode(json["content"].codeUnits),
    pubDate: json["pubDate"],
    imageUrl: json["image_url"],
    language: json["language"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "link": link,
    "video_url": videoUrl,
    "description": description,
    "content": content,
    "pubDate": pubDate,
    "image_url": imageUrl,
    "language": language,
  };
}

enum Category { TOP, SPORTS }

final categoryValues = EnumValues({
  "sports": Category.SPORTS,
  "top": Category.TOP
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
