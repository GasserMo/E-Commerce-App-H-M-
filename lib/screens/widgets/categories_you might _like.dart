import 'package:flutter/material.dart';
import 'package:store/models/category_model.dart';
import 'package:store/screens/Cart/cart_screen.dart';
import 'package:store/screens/FavoriteScreen/favorite_screen.dart';
import 'package:store/screens/Product/product_screen.dart';

class CategoriesYouMightLike extends StatelessWidget {
  const CategoriesYouMightLike({Key? key, required this.categories})
      : super(key: key);
  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return ProductScreen(category: category,);
                        },
                      ),
                    );
                  },
                  child: Image.asset(category.imageUrl,
                      fit: BoxFit.fill,
                      height: MediaQuery.of(context).size.height *0.1),
                ),
                Text(
                  category.name,
                  style: TextStyle(color: Colors.black, fontSize: 10),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  category.subtitle,
                  style: TextStyle(color: Colors.grey, fontSize: 10),
                )
              ],
            ),
          );
        });
  }
}
