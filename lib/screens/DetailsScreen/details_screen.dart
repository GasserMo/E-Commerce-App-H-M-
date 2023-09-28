import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/blocs/cart/bloc/cart_bloc.dart';
import 'package:store/blocs/favorite/bloc/favorite_bloc.dart';
import 'package:store/models/favorite_model.dart';
import 'package:store/models/product_model.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key, required this.product}) : super(key: key);
  static const String routeName = '/details';

  static Route route({required Product product}) {
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName),
        builder: (context) {
          return DetailsScreen(
            product: product,
          );
        });
  }

  final Product product;
  @override
  Widget build(BuildContext context) {
    bool isAddedToCart = false;
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.transparent,
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Center(
                    child: Image.asset(
                      product.imageUrl,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned(
                      left: 20,
                      top: 20,
                      child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.arrow_back)))),
                  BlocBuilder<FavoriteBloc, FavoriteState>(
                    builder: (context, state) {
                      final isFavorite = state is FavoriteLoaded &&
                          state.favorite.products.contains(product);
                      return Positioned(
                        right: 20,
                        top: 20,
                        child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: GestureDetector(
                              onTap: () {
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
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    '${product.price}',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: SizedBox()),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*0.05,
                color: Colors.transparent,
                child: BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                final isInCart = state is CartLoaded &&
                    state.cart.products.contains(product);
                return GestureDetector(
                  onTap: () {
                    if (isInCart) {
                      BlocProvider.of<CartBloc>(context)
                          .add(RemoveProduct(product));
                    } else {
                      BlocProvider.of<CartBloc>(context)
                          .add(AddProduct(product));
                    }
                    final snackBar = SnackBar(
                      content: Text(isInCart
                          ? 'Removed from CART'
                          : 'Added to CART'),
                    );
                    ScaffoldMessenger.of(context)
                        .showSnackBar(snackBar);
                  },
                  child: Container(
                    color: Colors.grey,
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons
                            .shopping_bag_outlined), // Change icon based on state
                        SizedBox(
                          width: 10,
                        ),
                        Text(isInCart ? 'Done ' : 'Add'),
                      ],
                    ),
                  ),
                );
              },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
