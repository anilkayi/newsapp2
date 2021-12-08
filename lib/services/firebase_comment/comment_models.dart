import 'package:cloud_firestore/cloud_firestore.dart';

class UserComment {
  String comment_id;
  String user_name;
  String comment;
  String title;
  String urlToImage;

  UserComment(
      {required this.comment_id,
      required this.user_name,
      required this.comment,
      required this.title,
      required this.urlToImage});

  factory UserComment.fromJson(String key, Map<dynamic, dynamic> json) {
    return UserComment(
        comment_id: key,
        user_name: json["user_name"],
        comment: json["comment"],
        title: json["title"],
        urlToImage: json["urlToImage"]);
  }
}
