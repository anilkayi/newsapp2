// To parse this JSON data, do
//
//     final newsModels = newsModelsFromJson(jsonString);

import 'dart:convert';
import 'package:crypto/crypto.dart';

NewsModels newsModelsFromJson(String str) =>
    NewsModels.fromJson(json.decode(str));

String newsModelsToJson(NewsModels data) => json.encode(data.toJson());

class NewsModels {
  NewsModels({
    this.status,
    this.totalResults,
    this.articles,
  });

  String? status;
  int? totalResults;
  List<Article>? articles;

  factory NewsModels.fromJson(Map<String, dynamic> json) => NewsModels(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: List<Article>.from(
            json["articles"].map((x) => Article.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "articles": List<dynamic>.from(articles!.map((x) => x.toJson())),
      };
}

class Article {
  Article({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
    this.data_id,
  });

  Source? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  DateTime? publishedAt;
  String? content;
  String? data_id;

  String get hash => md5
      .convert(utf8.encode(jsonEncode(this.source)) +
          utf8.encode('.') +
          utf8.encode(url!))
      .toString();

  factory Article.fromJson(Map<String, dynamic> json) => Article(
      source: Source.fromJson(json["source"]),
      author: json["author"] == null ? null : json["author"],
      title: json["title"],
      description: json["description"],
      url: json["url"],
      urlToImage: json["urlToImage"],
      publishedAt: DateTime.parse(json["publishedAt"]),
      content: json["content"],
      data_id: json["data_id"]);

  Map<String, dynamic> toJson() => {
        "source": source!.toJson(),
        "author": author == null ? null : author,
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt!.toIso8601String(),
        "content": content,
        "data_id": data_id,
      };
}

class Source {
  Source({
    this.id,
    this.name,
  });

  dynamic id;
  String? name;

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
