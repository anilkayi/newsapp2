import 'package:firebase_database/firebase_database.dart';

class RemoveFavorite {
  var refFavorite = FirebaseDatabase.instance.reference().child('Favorite');
  Future<void> removeFav(String id) async {
    refFavorite.child(id).remove();
  }
}
