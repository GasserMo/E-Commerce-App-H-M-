import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:store/models/cart.dart';
import 'package:store/models/checkout_model.dart';
import 'package:store/models/product_model.dart';
import 'package:store/repositiries/local%20storage/Cart%20storage/cart_repositiry.dart';

class FireStoreCart extends BaseCartFirestoreRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> saveCartDataToFirestore(String userUid, Cart cart) async {
    final userCartRef = _firestore.collection('carts').doc(userUid);

    try {
      final cartData = {
        'products': cart.products
            .map((product) => {
                  'name': product.name,
                  'imageUrl': product.imageUrl,
                  'price': product.price,
                  'isRecommended': product.isRecommended,
                  'category': product.category,
                  // Add other product properties as needed
                })
            .toList(),
      };
      await userCartRef.set(cartData);

      // Simulate a delay (replace with actual Firestore interaction)
    } catch (e) {
      throw Exception('Failed to add the order: $e');
    }
  }

  @override
  Future<Cart> fetchCartDataFromFirestore(String userUid) async {
    final firestore = FirebaseFirestore.instance;
    final userCartRef = firestore.collection('carts').doc(userUid);

    try {
      final userCartDoc = await userCartRef.get();

      if (userCartDoc.exists) {
        // Deserialize the cart data and return it as a Cart object
        final cartData = userCartDoc.data() as Map<String, dynamic>;
        final List<Product> products = cartData['products'].map((productData) {
          // Deserialize each product from the map
          return Product(
            name: productData['name'],
            imageUrl: productData['imageUrl'],
            price: productData['price'],
            isRecommended: productData['isRecommended'],
            category: productData['category'],
            // Add other product properties as needed
          );
        }).toList();

        return Cart(products: products);
      } else {
        // User has no cart data, return an empty cart
        return Cart(products: []);
      }
    } catch (e) {
      // Handle errors here
      print('Error fetching cart data: $e');
      return Cart(products: []);
    }
  }

  @override
  Future<void> removeProductFromCart(String userUid, String productName) async {
    final userCartRef = _firestore.collection('carts').doc(userUid);

    try {
      final userCartDoc = await userCartRef.get();
      if (userCartDoc.exists) {
        final cartData = userCartDoc.data() as Map<String, dynamic>;
        final List<dynamic> productsData = cartData['products'];

        // Filter out the product to remove by matching the name
        final updatedProductsData = productsData
            .where((productData) => productData['name'] != productName)
            .toList();

        // Update the cart with the filtered products
        final updatedCartData = {'products': updatedProductsData};
        await userCartRef.set(updatedCartData);

        // Simulate a delay (replace with actual Firestore interaction)
      }
    } catch (e) {
      throw Exception('Failed to remove product from the cart: $e');
    }
  }
  @override
  Future<void> deleteCart(String userUid) async {
  final userCartRef = _firestore.collection('carts').doc(userUid);

  try {
    await userCartRef.delete();
  } catch (e) {
    throw Exception('Failed to delete the cart: $e');
  }
}
}


/* class CartStorageRepository extends BaseCartLocalStorageRepository {
  static const kCartBox = 'cart_box';

  @override
  Future<Box> openBox() async {
    Box box = await Hive.openBox<Product>(kCartBox);
    return box;
  }

  @override
  List<Product> getCart(Box box) {
    return box.values.toList() as List<Product>;
  }

  @override
  Future<void> addToCart(Box box, Product product) async {
    await box.put(product.name, product);
  }

  @override
  Future<void> RemoveFromCart(Box box, Product product) async {
    await box.delete(product.name);
  }

  @override
  Future<void> Clear(Box box) async {
    await box.clear();
  }

} */