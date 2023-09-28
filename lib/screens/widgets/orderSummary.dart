import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/blocs/cart/bloc/cart_bloc.dart';
import 'package:store/screens/checkout/checkout_screen.dart';

class OrderSummary extends StatelessWidget {
  OrderSummary({super.key, required this.text, required this.onTap});
  final String text;
  Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoading) {
          return CircularProgressIndicator();
        }
        if (state is CartLoaded) {
          return Column(
            children: [
              Container(
                height: 40,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text:
                                'Total',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text:
                                ' (Inclusive of VAT. Excluding delivery)',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ]),
                      ),
                      Text(
                        '\$ ${state.cart.subtotal.roundToDouble()}',
                        style: TextStyle(
                          
                          fontSize: 15,
                          overflow: TextOverflow.ellipsis,
                          color: Colors.black,

                          fontWeight: FontWeight.bold, // Set to normal weight
                        ),
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: onTap,
                child: Container(
                  height: 50,
                  margin: EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: Colors.black),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          text,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        }
        return Text('Something went wrong');
      },
    );
  }
}
