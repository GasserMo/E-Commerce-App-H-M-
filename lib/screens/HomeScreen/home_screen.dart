import 'package:flutter/material.dart';
import 'package:store/models/category_model.dart';
import 'package:store/models/product_model.dart';
import 'package:store/screens/SearchScreen/search.dart';
import 'package:store/screens/widgets/appBar.dart';
import 'package:store/screens/widgets/categories_you%20might%20_like.dart';
import 'package:store/screens/widgets/category_card.dart';
import 'package:store/screens/widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName),
        builder: (context) {
          return HomeScreen();
        });
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final products=Product.products;
    final product =
        Product.products.where((element) => element.isRecommended).toList();

    
    final List<Category> notfilteredCategories =
        Category.categories.where((category) => category.mightLike).toList();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: CustomAppBar(),
        ),
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: GestureDetector(
                  onTap: () {
                    showSearch(context: context, delegate: Search(
                      products
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
                        )
                      ],
                    ),
                  )),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20),
                child: Text(
                  'Categories you might like',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CategoriesYouMightLike(
                      categories: notfilteredCategories,
                    ),
                  )),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 10, left: 20),
                child: Text(
                  'Recommended For You',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: product.length,
                      itemBuilder: (context, index) {
                        return ProductCard(
                          product: product[index],
                          imageHeight: MediaQuery.of(context).size.height * 0.3,
                        );
                      },
                    ),
                  )),
            ),
          ],
        ));
  }
}
