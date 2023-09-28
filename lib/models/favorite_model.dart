import 'package:equatable/equatable.dart';
import 'package:store/models/product_model.dart';

class Favorite extends Equatable {
  final List<Product> products;

  const Favorite({this.products = const <Product>[]});
  
 Map FavoriteQuantity(products){
  var quantity =Map();

  products.forEach((product){
    if(!quantity.containsKey(product)){
      quantity[product]=1;
    }else{
      return quantity[product]=1;  
    }
  });
  return quantity;
 }

  @override
  // TODO: implement props
  List<Object?> get props => [products];
}
