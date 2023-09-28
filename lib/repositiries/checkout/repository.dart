import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:store/models/checkout_model.dart';

class FirestoreRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> placeOrder(CheckoutModel checkoutData) async {
    try {
      await _firestore.collection('orders').add(checkoutData.toDoucment());

      // Simulate a delay (replace with actual Firestore interaction)
      await Future.delayed(Duration(seconds: 2));
    } catch (e) {
      throw Exception('Failed to place the order: $e');
    }
  }
}
