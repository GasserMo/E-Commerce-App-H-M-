import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String name;
  final String imageUrl;
  final subtitle;
  final bool mightLike;
  Category({ required this.mightLike, 
      required this.name, required this.imageUrl, required this.subtitle});

  static List<Category> categories = [
    Category(
      name: 'Men',
      subtitle: 'hoodies',
        mightLike:true,
      imageUrl:
          'assets/images/categories/categorieshoodies.png', //https://unsplash.com/photos/5lZhD2qQ2SE
    ),
    Category(
      name: 'Women', subtitle: 'blouse',
        mightLike:true,

      imageUrl:
          'assets/images/categories/categoriesblouses.png', //https://unsplash.com/photos/m741tj4Cz7M
    ),
   
    Category(
      name: 'Women', subtitle: 'dress',
        mightLike:true,

      imageUrl:
          'assets/images/categories/categoriesdress.png', //https://unsplash.com/photos/5lZhD2qQ2SE
    ),
    Category(
      name: 'Men', subtitle: 'tshirt',
        mightLike:true,

      imageUrl:
          'assets/images/categories/categoriestshirt.png', //https://unsplash.com/photos/m741tj4Cz7M
    ),
  
   
     Category(
      name: 'Kids', subtitle: '',
        mightLike:false,

      imageUrl:
          'assets/images/categories/baby.jpg', //https://unsplash.com/photos/m741tj4Cz7M
    ),
       Category(
      name: 'Sports', subtitle: '',
        mightLike:false,

      imageUrl:
          'assets/images/categories/sport2.jpg', //https://unsplash.com/photos/m741tj4Cz7M
    ),
     Category(
      name: 'Divided', subtitle: '',
        mightLike:false,

      imageUrl:
          'assets/images/categories/divided.jpg', //https://unsplash.com/photos/m741tj4Cz7M
    ),
     Category(
      name: 'Men', subtitle: '',
        mightLike:false,

      imageUrl:
          'assets/images/categories/men.jpg', //https://unsplash.com/photos/m741tj4Cz7M
    ),
  ];

  @override
  // TODO: implement props
  List<Object?> get props => [name, imageUrl,subtitle,mightLike];
}
