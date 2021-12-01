import 'package:firebase_database/firebase_database.dart';
import 'package:newsapp2/models/NewsFavoriteModels.dart';
import 'package:newsapp2/models/NewsModels.dart';

class UserFavorite {
  var refFavorite = FirebaseDatabase.instance.reference().child('Favorite');
  Future<void> favoriteNews() async {
    refFavorite.once().then((DataSnapshot snapshot) {
      var favNews = snapshot.value;

      if (favNews != null) {
        favNews.forEach((key, nesne) {
          var userNew = NewsFavorite.fromJson(nesne);
        });
      }
    });
  }
}
