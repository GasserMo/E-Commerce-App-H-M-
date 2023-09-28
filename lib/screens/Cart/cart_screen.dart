import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/blocs/cart/bloc/cart_bloc.dart';
import 'package:store/constants.dart';
import 'package:store/core/services/api_services.dart';
import 'package:store/core/styles.dart';
import 'package:store/models/product_model.dart';
import 'package:store/screens/checkout/checkout_screen.dart';
import 'package:store/screens/widgets/cart_product_Card.dart';
import 'package:store/screens/widgets/orderSummary.dart';
import 'package:store/screens/widgets/product_card.dart';

class CartScreen extends StatelessWidget {
  CartScreen({Key? key}) : super(key: key);
  static const String routeName = '/cart';

  static Route route() {
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName),
        builder: (context) {
          return CartScreen();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'My Cart',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ],
        ),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CartLoaded) {
            List<String?> selectedSizes =
                List.filled(state.cart.products.length, null);

            if (state.cart.products.isEmpty)
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shopping_cart),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Your Cart is empty',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Add your loved item so you don\'t lose sight of them and for easy shopping later',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () {
                              BlocProvider.of<CartBloc>(context)
                                  .add(ClearCart());
                            },
                            child: Text(
                              'clear cart',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 20),
                            )),
                        Text(
                          '${state.cart.products.length} Items',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: state.cart
                            .productQuantity(state.cart.products)
                            .keys
                            .length,
                        itemBuilder: (context, index) {
                          return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CartProductCard(
                                onSizeSelected: (size) {
                                  // Update the selectedSizes list at the corresponding index
                                  selectedSizes[index] = size;
                                },
                                quantity: state.cart
                                    .productQuantity(state.cart.products)
                                    .values
                                    .elementAt(index),
                                product: state.cart
                                    .productQuantity(state.cart.products)
                                    .keys
                                    .elementAt(index),
                              ));
                        }),
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  OrderSummary(
                    text: 'Checkout',
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (contxet) {
                        return Checkout(
                          cartProducts: state.cart.products,
                        );
                      }));
                    },
                  ),
                ],
              ),
            );
          }
          return Text('something is wrong');
        },
      ),
    );
  }
}
