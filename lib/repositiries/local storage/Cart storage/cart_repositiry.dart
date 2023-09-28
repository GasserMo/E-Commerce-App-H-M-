import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:store/models/cart.dart';
import 'package:store/models/checkout_model.dart';
import 'package:store/models/product_model.dart';

abstract class BaseCartFirestoreRepository {
  Future<void> saveCartDataToFirestore(String userUid, Cart cart);

  Future<Cart> fetchCartDataFromFirestore(String userUid);
  Future<void> removeProductFromCart(String userUid, String productName);
    Future<void> deleteCart(String userUid);

}
