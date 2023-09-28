import 'package:flutter/material.dart';
import 'package:store/models/category_model.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.categories,
  });
  final Category categories;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
                child: Image.asset(
                  categories.imageUrl,
                  fit: BoxFit.fill,
                ),
                color: Colors.amber,
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width * 0.4),
            Positioned(top: 20,
            left: 20,
              child: Text(
                categories.name,
                style: TextStyle(fontSize: 20),
              ),
            ),
           
          ],
        ),
      ],
    );
  }
}
