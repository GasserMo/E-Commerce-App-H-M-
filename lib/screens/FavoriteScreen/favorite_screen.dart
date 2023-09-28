import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/blocs/favorite/bloc/favorite_bloc.dart';
import 'package:store/constants.dart';
import 'package:store/core/styles.dart';
import 'package:store/screens/DetailsScreen/details_screen.dart';
import 'package:store/screens/widgets/cart_product_Card.dart';
import 'package:store/screens/widgets/favorite_product_card.dart';
import 'package:store/screens/widgets/product_card.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);
  static const String routeName = '/favorite';

  static Route route() {
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName),
        builder: (context) {
          return FavoriteScreen();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'My favourites',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ],
        ),
      ),
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          if (state is FavoriteLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is FavoriteLoaded) {
            if (state.favorite.products.isEmpty) 
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.favorite_border),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Your favourites is empty',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Save your favourites item so you don\'t lose sight of them and for easy shopping later',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                      textAlign:TextAlign.center,
                    ),
                  ],
                ),
              );
            
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: state.favorite
                      .FavoriteQuantity(state.favorite.products)
                      .keys
                      .length,
                  itemBuilder: (context, index) {
                    return FavoriteProductCard(
                      product: state.favorite.products[index],
                    );
                  }),
            );
          }
          return Text('something is wrong');
        },
      ),
    );
  }
}
