import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:store/models/cart.dart';
import 'package:store/models/checkout_model.dart';
import 'package:store/models/favorite_model.dart';
import 'package:store/models/product_model.dart';
import 'package:store/repositiries/local%20storage/Cart%20storage/cart_repositiry.dart';
import 'package:store/repositiries/local%20storage/Fav%20storage/fav_repositiry.dart';

class FireStoreFavorite extends BaseFavFirestoreRepoistory {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> saveFavDataToFirestore(String userUid, Favorite favorite) async {
    final userCartRef = _firestore.collection('favorites').doc(userUid);

    try {
      final favData = {
        'products': favorite.products
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
      await userCartRef.set(favData);

      // Simulate a delay (replace with actual Firestore interaction)
    } catch (e) {
      throw Exception('Failed to add the order: $e');
    }
  }

  @override
  Future<Favorite> fetchFavDataFromFirestore(String userUid) async {
    final firestore = FirebaseFirestore.instance;
    final userCartRef = firestore.collection('favorites').doc(userUid);

    try {
      final userFavDoc = await userCartRef.get();

      if (userFavDoc.exists) {
        // Deserialize the cart data and return it as a Cart object
        final favData = userFavDoc.data() as Map<String, dynamic>;
        final List<Product> products = favData['products'].map((productData) {
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

        return Favorite(products: products);
      } else {
        // User has no cart data, return an empty cart
        return Favorite(products: []);
      }
    } catch (e) {
      // Handle errors here
      print('Error fetching cart data: $e');
      return Favorite(products: []);
    }
  }

  @override
  Future<void> removeProductFromFav(String userUid, String productName) async {
    final userFavRef = _firestore.collection('favorites').doc(userUid);
    try {
      final userFavDoc = await userFavRef.get();
      if (userFavDoc.exists) {
        final favData = userFavDoc.data() as Map<String, dynamic>;
        final List<dynamic> productsData = favData['products'];

        final updatedProductsData = productsData
            .where((productData) => productData['name'] != productName)
            .toList();

        // Update the cart with the filtered products
        final updatedFavData = {'products': updatedProductsData};
        await userFavRef.set(updatedFavData);
      }
    } catch (e) {}
  }

  @override
  Future<void> deleteCart(String userUid) async {
    final userCartRef = _firestore.collection('favorites').doc(userUid);

    try {
      await userCartRef.delete();
    } catch (e) {
      throw Exception('Failed to delete the favorites: $e');
    }
  }
}





/* class FavLocalStorageRepository extends BaseFavLocalStorageRepoisitory {
  static const kFavBox = 'fav_box';

  @override
  Future<Box> openBox() async {
    Box box = await Hive.openBox<Product>(kFavBox);
    return box;
  }

  @override
  List<Product> getFavorite(Box box) {
    return box.values.toList() as List<Product>;
  }

  @override
  Future<void> addProductToFav(Box box, Product product) async {
    await box.put(product.name, product);
  }

  @override
  Future<void> RemoveProductFromFav(Box box, Product product) async {
    await box.delete(product.name);
  }

  @override
  Future<void> clearFav(Box box)async {
    await box.clear();
  }
  
}
 */