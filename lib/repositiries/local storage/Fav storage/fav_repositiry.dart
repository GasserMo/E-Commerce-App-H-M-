import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:store/models/cart.dart';
import 'package:store/models/checkout_model.dart';
import 'package:store/models/favorite_model.dart';
import 'package:store/models/product_model.dart';

abstract class BaseFavFirestoreRepoistory {
  Future<void> saveFavDataToFirestore(String userUid, Favorite favorite);
  Future<void> removeProductFromFav(String userUid, String productName);

  Future<Favorite> fetchFavDataFromFirestore(String userUid);
      Future<void> deleteCart(String userUid);

}
