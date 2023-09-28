import 'package:flutter/material.dart';
import 'package:store/constants.dart';
import 'package:store/core/services/api_services.dart';
import 'package:store/models/product_model.dart';
import 'package:store/screens/DetailsScreen/details_screen.dart';

class Search extends SearchDelegate {
  final List<Product> product;
  FetchData data = FetchData();
  Search(this.product);
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      hintColor: Colors.white,
      appBarTheme: AppBarTheme(
        elevation: 1,
        color: Colors.white,
        iconTheme: theme.primaryIconTheme.copyWith(color: Colors.grey),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: Colors.black, // Set your desired cursor color here
      ),
      inputDecorationTheme: InputDecorationTheme(
        focusColor: Colors.white,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: Colors.transparent), // Set your desired focus color here
        ),
      ),
    );
  }

  
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, '');
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final filteredProducts = product.where((product) {
      return product.name.toLowerCase().contains(query.toLowerCase());
    }).toList();
    if (query.isEmpty) {
      // Display your custom content when no search query is entered
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25),
            child: Text(
              "Trending searches",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Row(
            children: [
              Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.1,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          color: Colors.yellow.withOpacity(0.1),
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: MediaQuery.of(context).size.height * 0.02,
                          child: Center(child: Text('dress')),
                        ),
                      );
                    }),
              )
            ],
          )
        ],
      );
    }

    return FutureBuilder(
        future: null,
        builder: (context, snapshot) {
          return ListView.builder(
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Container(
                    color: backgroundColor,
                    child: ListTile(
                      title: Text(filteredProducts[index].name),
                      subtitle: Text(filteredProducts[index].category),
                      leading: Image.asset(
                        filteredProducts[index].imageUrl,
                      ),
                      // Handle item selection as needed
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return DetailsScreen(
                              product: filteredProducts[index]);
                        }));
                      },
                    ),
                  ),
                );
              });
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final filteredProducts = product.where((product) {
      return product.name.toLowerCase().contains(query.toLowerCase());
    }).toList();
    if (query.isEmpty) {
      // Display your custom content when no search query is entered
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25),
            child: Text(
              "Trending searches",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Row(
            children: [
              Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.1,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          color: Colors.yellow.withOpacity(0.1),
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: MediaQuery.of(context).size.height * 0.02,
                          child: Center(child: Text('dress')),
                        ),
                      );
                    }),
              )
            ],
          )
        ],
      );
    }

    return FutureBuilder(
        future: null,
        builder: (context, snapshot) {
          return ListView.builder(
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Container(
                    color: backgroundColor,
                    child: ListTile(
                      leading: Image.asset(
                        filteredProducts[index].imageUrl,
                      ),
                      title: Text(filteredProducts[index].name),
                      subtitle: Text(filteredProducts[index].category),

                      // Handle item selection as needed
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return DetailsScreen(
                              product: filteredProducts[index]);
                        }));
                      },
                    ),
                  ),
                );
              });
        });
  }
}
