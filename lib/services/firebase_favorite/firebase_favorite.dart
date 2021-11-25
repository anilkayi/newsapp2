import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FavoriteClass {
  Future<void> AddFavorite(Favorite) async {
    FirebaseFirestore.instance
        .collection('Favorite')
        .add(Favorite)
        .catchError((error) {
      Fluttertoast.showToast(msg: 'Error');
    });
  }
}
