import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/blocs/cart/bloc/cart_bloc.dart';
import 'package:store/blocs/favorite/bloc/favorite_bloc.dart';
import 'package:store/models/product_model.dart';
import 'package:store/screens/DetailsScreen/details_screen.dart';

final _firebaseAuth = FirebaseAuth.instance;

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.imageHeight,
  });
  final Product product;
  final double imageHeight;

  @override
  Widget build(BuildContext context) {
    bool isAdded = false;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.height * 0.3,
        child: Column(
          children: [
            Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return DetailsScreen(
                        product: product,
                      );
                    }));
                  },
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white30),
                    child: Image.asset(
                      product.imageUrl,
                      fit: BoxFit.fill,
                      height: imageHeight,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                ),
                BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    
                    return Positioned(
                        right: 10,
                        top: 10,
                        child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: GestureDetector(
                              onTap: () {
                                if (_firebaseAuth.currentUser != null) {
                                  BlocProvider.of<CartBloc>(context)
                                      .add(AddProduct(product));
                                  final snackBar =
                                      SnackBar(content: Text('added'));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                } else {
                                  final snackBar = SnackBar(
                                      content: Text('You Need To Sign in'));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              },
                              child: Icon(Icons.shopping_cart),
                            )));
                  },
                ),
                BlocBuilder<FavoriteBloc, FavoriteState>(
                  builder: (context, state) {
                    final isFavorite = state is FavoriteLoaded &&
                        state.favorite.products.contains(product);
                    return Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: GestureDetector(
                            onTap: () {
                              if (_firebaseAuth.currentUser != null) {
                                final snackBar = SnackBar(
                                  content: Text(isFavorite
                                      ? 'Removed from fav'
                                      : 'Added to fav'),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);

                                if (isFavorite) {
                                  BlocProvider.of<FavoriteBloc>(context)
                                      .add(RemoveProductFromFavorite(product));
                                } else {
                                  BlocProvider.of<FavoriteBloc>(context)
                                      .add(AddProductToFavorite(product));
                                }
                              } else {
                                final snackBar = SnackBar(
                                    content: Text('You Need To Sign in'));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            },
                            child: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isFavorite ? Colors.red : Colors.grey,
                            ),
                          )),
                    );
                  },
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '\$ ${product.price}',
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
