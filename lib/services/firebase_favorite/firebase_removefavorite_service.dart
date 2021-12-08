import 'package:firebase_database/firebase_database.dart';

class RemoveFavorite {
  var refFavorite = FirebaseDatabase.instance.reference().child('Favorite');
  Future<void> removeFav(String data_id) async {
    refFavorite.child(data_id).remove();
  }
}
