import 'dart:collection';
import 'package:firebase_database/firebase_database.dart';
import 'package:newsapp2/models/NewsModels.dart';

class FavoriteClass {
  var refFavorite = FirebaseDatabase.instance.reference().child('Favorite');

  Future<void> AddFavorite(String urltoImage, String title, String source,
      String description) async {
    var data = HashMap<String, dynamic>();
    data["urltoImage"] = urltoImage;
    data['title'] = title;
    data['source'] = source;
    data['description'] = description;
    refFavorite.push().set(data);
  }
}
