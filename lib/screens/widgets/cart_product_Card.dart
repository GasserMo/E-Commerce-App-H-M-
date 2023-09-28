import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/blocs/cart/bloc/cart_bloc.dart';
import 'package:store/constants.dart';
import 'package:store/models/product_model.dart';
import 'package:store/screens/widgets/cart_icon.dart';

class CartProductCard extends StatefulWidget {
  CartProductCard({
    Key? key,
    required this.product,
    required this.quantity,
    required this.onSizeSelected,
  }) : super(key: key);
  final Product product;
  final int quantity;
  Function(String) onSizeSelected;

  @override
  State<CartProductCard> createState() => _CartProductCardState();
}

class _CartProductCardState extends State<CartProductCard> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          child: Image.asset(
            widget.product.imageUrl,
            width: MediaQuery.of(context).size.width * 0.3,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.product.name,
                style: TextStyle(fontSize: 15, overflow: TextOverflow.ellipsis),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '${widget.product.price}',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    'Color:',
                    style: TextStyle(fontSize: 10),
                  ),
                  Text(
                    'Light Beige',
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),
              ProductSize(product: widget.product),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        BlocProvider.of<CartBloc>(context)
                            .add(RemoveProduct(widget.product));
                      },
                      icon: Icon(
                        Icons.remove_circle,
                      )),
                  Text(
                    '${widget.quantity}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.black),
                  ),
                  IconButton(
                      onPressed: () {
                        BlocProvider.of<CartBloc>(context)
                            .add(AddProduct(widget.product));
                        // Add with size 'M'
                      },
                      icon: Icon(
                        Icons.add_circle,
                      )),
                ],
              ),
            ],
          ),
        ),
        BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            return CartIcon(
              icon: Icon(Icons.delete),
              onPressed: () {
                BlocProvider.of<CartBloc>(context)
                    .add(RemoveProduct(widget.product));
                final snackBar = SnackBar(content: Text('Removed From Cart'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
            );
          },
        )
      ],
    );
  }
}

class ProductSize extends StatefulWidget {
  const ProductSize({
    super.key,
    required this.product,
  });
  final Product product;
  @override
  State<ProductSize> createState() => _ProductSizeState();
}

class _ProductSizeState extends State<ProductSize> {
  String? selectedSize; // Remove the default value 'S' here

  @override
  void initState() {
    super.initState();

    // Set the default size when the widget is initialized
    selectedSize = 'S'; // You can change 'S' to your desired default size
    widget.product.size = selectedSize;
  }

  void selectSize(String size) {
    setState(() {
      selectedSize = size;
      widget.product.size = selectedSize;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              // Call the function to select the size
              selectSize('S');
            },
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: selectedSize == 'S' ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  'S',
                  style: TextStyle(
                    color: selectedSize == 'S' ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              // Call the function to select the size
              selectSize('M');
            },
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: selectedSize == 'M' ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  'M',
                  style: TextStyle(
                    color: selectedSize == 'M' ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
        // Add similar GestureDetector and Container widgets for other sizes
      ],
    );
  }
}
