import 'package:cloud_firestore/cloud_firestore.dart';

class UserComment {
  String comment_id;
  String user_name;
  String comment;
  String title;
  String created_at;

  UserComment(
      {required this.comment_id,
      required this.user_name,
      required this.comment,
      required this.title,
      required this.created_at});

  factory UserComment.fromJson(Map<dynamic, dynamic> json) {
    return UserComment(
        comment_id: json["comment_id"],
        user_name: json["user_name"],
        comment: json["comment"],
        title: json["title"],
        created_at: json["created_at"]);
  }
}
