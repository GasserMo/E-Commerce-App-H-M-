import 'package:flutter/material.dart';
import 'package:store/models/category_model.dart';
import 'package:store/models/product_model.dart';
import 'package:store/screens/DetailsScreen/details_screen.dart';
import 'package:store/screens/widgets/product_card.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({
    Key? key,
    required this.category,
  }) : super(key: key);
  final Category category;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late List<Product> products;

  @override
  void initState() {
    super.initState();
    products = Product.products
        .where((product) => product.category == widget.category.name)
        .toList();
  }

  bool sortByPriceHighToLow = false;

  void toggleSorting() {
    setState(() {
      sortByPriceHighToLow = !sortByPriceHighToLow;
      if (sortByPriceHighToLow) {
        products.sort((a, b) => b.price.compareTo(a.price));
      } else {
        products.sort((a, b) => a.price.compareTo(b.price));
      }
    });
  }

  void onDropdownChanged(String newValue) {
    setState(() {
      dropdownValue = newValue;
      
      if (dropdownValue == 'From high to low') {
        products.sort((a, b) => b.price.compareTo(a.price));
      } else if (dropdownValue == 'From low to high') {
        products.sort((a, b) => a.price.compareTo(b.price));
      } else {
        return;
      }
    });
  }

  String? dropdownValue; // Default selection

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF4F4F4),
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        title: Text(
          'View All',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Row(
                  children: [
                    IconButton(
                        icon: Icon(Icons.sort),
                        onPressed: () {
                          setState(() {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)
                                    ),
                                      child: Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Sort by Price'),
                                              DropdownButton(
                                                  value: dropdownValue,
                                                  onChanged: (va) {
                                                    onDropdownChanged(va!);

                                                    Navigator.pop(context);
                                                  },
                                                  items: ['From high to low', 'From low to high']
                                                      .map((e) =>
                                                          DropdownMenuItem(
                                                            child: Text(e),
                                                            value: e,
                                                          ))
                                                      .toList())
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ));
                                });
                          });
                        }),
                    Text(
                      '${products.length} Item',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverGrid.builder(
            itemCount: products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height / 1.5),
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              final product = products[index];

              return ProductCard(
                product: product,
                imageHeight: MediaQuery.of(context).size.height * 0.2,
              );
            },
          )
        ],
      ),
    );
  }
}
