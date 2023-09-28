import 'package:equatable/equatable.dart';
import 'package:store/models/product_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';


class Cart extends Equatable {
   final List<Product> products;

   Cart({this.products = const <Product>[]});

   @override
   List<Object?> get props => [products];

   double get subtotal =>
      products.fold(0, (total, current) => total + current.price);

   String get subtotalString => subtotal.toStringAsFixed(2);

   Map productQuantity(products) {
      var quantity = Map();

      products.forEach((product) {
         if (!quantity.containsKey(product)) {
            quantity[product] = 1;
         } else {
            quantity[product] += 1;
         }
      });
      return quantity;
   }
}