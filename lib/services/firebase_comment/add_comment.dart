import 'dart:collection';
import 'package:firebase_database/firebase_database.dart';

class AddComment {
  var refComment = FirebaseDatabase.instance.reference().child('Comment');

  Future<void> CommentFunc(String comment_id, String user_name, String comment,
      String title, String created_at) async {
    var data = HashMap<String, dynamic>();
    data["comment_id"] = comment_id;
    data['title'] = title;
    data["comment"] = comment;
    data["user_name"] = user_name;
    data['created_at'] = created_at;

    refComment.push().set(data);
  }
}
