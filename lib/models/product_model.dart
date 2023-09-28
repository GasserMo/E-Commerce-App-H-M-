import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'product_model.g.dart';

@HiveType(typeId: 0)
class Product extends Equatable {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String imageUrl;
  @HiveField(2)
  final String category;
  @HiveField(3)
  final double price;
  @HiveField(4)
  final bool isRecommended;
  @HiveField(5)
  String? size;
  Product({
    this.size,
    required this.category,
    required this.price,
    required this.isRecommended,
    required this.name,
    required this.imageUrl,
  });
  Map productQuantity(products) {
    var quantity = Map();

    products.forEach((product) {
      if (!quantity.containsKey(product)) {
        quantity[product] = 1;
      } else {
        quantity[product] = 1;
      }
    });
    return quantity;
  }
  // Define the copyWith method

  static List<Product> products = [
    Product(
      name: 'Cotton T-shirt Regular Fit',
      category: 'Men',
      imageUrl:
          'assets/images/men/men1.webp', //https://unsplash.com/photos/dO9A6mhSZZY
      price: 25.99,
      isRecommended: true,
    ),
    Product(
      name: 'Slim Fit Pima cotton T-shirt',
      category: 'Men',
      imageUrl:
          'assets/images/men/men2.jpg', //https://unsplash.com/photos/dO9A6mhSZZY
      price: 20.99,
      isRecommended: true,
    ),
    Product(
      name: 'Relaxed Fit Jersey top',
      category: 'Men',
      imageUrl:
          'assets/images/men/men3.jpg', //https://unsplash.com/photos/dO9A6mhSZZY
      price: 26.99,
      isRecommended: false,
    ),
    Product(
      name: 'DryMove™ Sports top',
      category: 'Men',
      imageUrl:
          'assets/images/men/men4.jpg', //https://unsplash.com/photos/dO9A6mhSZZY
      price: 28.99,
      isRecommended: false,
    ),
    Product(
      name: 'Relaxed Fit Jersey top',

      category: 'Men',
      imageUrl:
          'assets/images/men/men5.jpg', //https://unsplash.com/photos/dO9A6mhSZZY
      price: 24.99,
      isRecommended: false,
    ),
    Product(
      name: 'Draped satin skirt',
      category: 'Women',
      imageUrl:
          'assets/images/women/women1.jpg', //https://unsplash.com/photos/dO9A6mhSZZY
      price: 25.99,
      isRecommended: false,
    ),
    Product(
      name: 'Straight High Jeans',

      category: 'Women',
      imageUrl:
          'assets/images/women/women2.jpg', //https://unsplash.com/photos/dO9A6mhSZZY
      price: 32.99,
      isRecommended: true,
    ),
    Product(
      name: 'Frill-trimmed maxi dress',

      category: 'Women',
      imageUrl:
          'assets/images/women/women3.jpg', //https://unsplash.com/photos/dO9A6mhSZZY
      price: 35.99,
      isRecommended: false,
    ),
    Product(
      name: 'Wide High Jeans',

      category: 'Women',
      imageUrl:
          'assets/images/women/women4.jpg', //https://unsplash.com/photos/dO9A6mhSZZY
      price: 38.99,
      isRecommended: true,
    ),
    Product(
      name: '2-pack cotton joggers',

      category: 'Kids',
      imageUrl:
          'assets/images/kids/kids1.jpg', //https://unsplash.com/photos/dO9A6mhSZZY
      price: 38.99,
      isRecommended: false,
    ),
    Product(
      name: 'Cotton shorts',

      category: 'Kids',
      imageUrl:
          'assets/images/kids/kids3.webp', //https://unsplash.com/photos/dO9A6mhSZZY
      price: 38.99,
      isRecommended: false,
    ),
    Product(
      name: '3-pack ribbed Henley tops',

      category: 'Kids',
      imageUrl:
          'assets/images/kids/kids4.jpg', //https://unsplash.com/photos/dO9A6mhSZZY
      price: 38.99,
      isRecommended: false,
    ),
    Product(
      name: '2-piece printed sweatshirt set',

      category: 'Kids',
      imageUrl:
          'assets/images/kids/kids5.webp', //https://unsplash.com/photos/dO9A6mhSZZY
      price: 38.99,
      isRecommended: true,
    ),
  ];

  @override
  // TODO: implement props
  List<Object?> get props => [
        name,
        imageUrl,
        size,
        category,
        price,
        isRecommended,
      ];
}
