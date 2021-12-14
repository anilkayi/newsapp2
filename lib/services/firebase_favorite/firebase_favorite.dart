import 'dart:collection';
import 'package:firebase_database/firebase_database.dart';

class FavoriteClass {
  var refFavorite = FirebaseDatabase.instance.reference().child('Favorite');

  Future<void> AddFavorite(String urltoImage, String title, String source,
      String description, String hash) async {
    var data = HashMap<String, dynamic>();
    data["data_id"] = '';
    data["urltoImage"] = urltoImage;
    data['title'] = title;
    data['source'] = source;
    data['description'] = description;
    data['fav_id'] = hash;
    refFavorite.push().set(data);
  }
}
