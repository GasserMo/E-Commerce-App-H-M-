import 'package:flutter/material.dart';
import 'package:store/models/category_model.dart';
import 'package:store/models/product_model.dart';
import 'package:store/screens/SearchScreen/search.dart';
import 'package:store/screens/widgets/category_card.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class SearchScreen extends StatelessWidget {
   SearchScreen({Key? key, required this.category}) : super(key: key);
  static const String routeName = '/search';
  static Route route({required Category category}) {
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName),
        builder: (context) {
          return SearchScreen(
            category: category,
          );
        });
  }

  final Category category;

  @override
  Widget build(BuildContext context) {

    
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          'Search',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              showSearch(context: context, delegate: Search(
                Product.products
              ));
            },
            child: Container(
              color: Colors.grey.withOpacity(0.05),
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Icon(Icons.search),
                  ),
                  Text(
                    'Start typing to search',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}
