import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/blocs/cart/bloc/cart_bloc.dart';
import 'package:store/blocs/favorite/bloc/favorite_bloc.dart';
import 'package:store/models/product_model.dart';
import 'package:store/screens/widgets/cart_icon.dart';

class FavoriteProductCard extends StatelessWidget {
  const FavoriteProductCard({
    super.key,
    required this.product,
  });
  final Product product;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              child: Image.asset(
                product.imageUrl,
                width: MediaQuery.of(context).size.width * 0.3,
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        product.name,
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        '\$${product.price}',
                        style: TextStyle(fontSize: 15),
                      ),
                      Row(
                        children: [
                          Text('Color: '),
                          Text('Light beige'),
                        ],
                      ),
                      BlocBuilder<CartBloc, CartState>(
                        builder: (context, state) {
                          return GestureDetector(
                            onTap: () {
                              BlocProvider.of<CartBloc>(context)
                                  .add(AddProduct(product));
                              BlocProvider.of<FavoriteBloc>(context)
                                  .add(RemoveProductFromFavorite(product));
                              final snackBar =
                                  SnackBar(content: Text('Added To Cart'));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            },
                            child: Container(
                              child: Center(
                                child: Text(
                                  'Add To Cart',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              height: MediaQuery.of(context).size.height * 0.04,
                              width: MediaQuery.of(context).size.width * 0.5,
                              decoration: BoxDecoration(color: Colors.black),
                            ),
                          );
                        },
                      ),
                    ]),
              ),
            ),
            BlocBuilder<FavoriteBloc, FavoriteState>(
              builder: (context, state) {
                return CartIcon(
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    BlocProvider.of<FavoriteBloc>(context)
                        .add(RemoveProductFromFavorite(product));
                    final snackBar =
                        SnackBar(content: Text('Removed From Favorite'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
