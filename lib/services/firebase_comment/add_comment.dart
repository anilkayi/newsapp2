import 'dart:collection';
import 'package:firebase_database/firebase_database.dart';

class AddComment {
  var refComment = FirebaseDatabase.instance.reference().child('Comment');

  Future<void> CommentFunc(String hash, String user_name, String comment,
      String title, String urlToImage) async {
    var data = HashMap<String, dynamic>();
    data["data_id"] = hash;
    data["urltoImage"] = urlToImage;
    data['title'] = title;
    data["user_name"] = user_name;
    data['created_at'] = DateTime.now();

    refComment.push().set(data);
  }
}
