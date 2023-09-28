import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/blocs/cart/bloc/cart_bloc.dart';
import 'package:store/blocs/checkout/bloc/checkout_bloc.dart';
import 'package:store/models/cart.dart';
import 'package:store/models/checkout_model.dart';
import 'package:store/models/product_model.dart';
import 'package:store/screens/widgets/orderSummary.dart';

class Checkout extends StatefulWidget {
  final List<Product> cartProducts;

  const Checkout({
    Key? key,
    required this.cartProducts,
  }) : super(key: key);
  static const String routeName = '/checkout';

  static Route route() {
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName),
        builder: (context) {
          return Checkout(
            cartProducts: [],
          );
        });
  }

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _fullNameController = TextEditingController();

  final TextEditingController _addressController = TextEditingController();

  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _buildingDetailsController =
      TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  final TextEditingController _countryController = TextEditingController();

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
          'Home Delivery',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),
      body: BlocConsumer<CheckoutBloc, CheckoutState>(
        listener: (context, state) {
          if (state is CheckoutSuccess) {
            // Order placed successfully, navigate to a success screen or homepage
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Success'),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is CheckoutFailure) {
            // Handle order placement failure
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Order placement failed: ${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      SizedBox(height: 10.0),
                      BillingDetails(
                        title: 'Full name',
                      ),
                      TextFormFieldd(
                        context,
                        _fullNameController,
                        (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your full name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.0),
                      BillingDetails(
                        title: 'City',
                      ),
                      TextFormFieldd(
                        context,
                        _cityController,
                        (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your full name';
                          }
                          return null;
                        },
                      ),
                      BillingDetails(
                        title: 'Country',
                      ),
                      TextFormFieldd(
                        context,
                        _countryController,
                        (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your full name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.0),
                      BillingDetails(
                        title: 'Street Address',
                      ),
                      TextFormFieldd(
                        context,
                        _addressController,
                        (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your full name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.0),
                      BillingDetails(
                        title: 'Building Name /Number & Floor NO , 4th ',
                      ),
                      TextFormFieldd(
                        context,
                        _buildingDetailsController,
                        (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your full name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.0),
                      BillingDetails(
                        title: 'Contact Number',
                      ),
                      TextFormFieldd(
                        context,
                        _contactController,
                        (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your full name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.0),
                    ],
                  ),
                ),
                Divider(
                  thickness: 2,
                ),
                SizedBox(height: 10.0),
                GestureDetector(
                  onTap: () {
                    double total = widget.cartProducts
                        .map((product) => product.price)
                        .reduce((total, price) => total + price);
                    final List<Map<String, dynamic>> productsData =
                        widget.cartProducts.map((product) {
                      return {
                        'name': product.name,
                        'category': product.category,
                        'price': product.price,
                        'size': product.size, // Include the selected size
                      };
                    }).toList();
                    if (_formKey.currentState!.validate()) {
                      // Create a CheckoutModel with the collected data
                      final checkoutData = CheckoutModel(
                        fullName: _fullNameController.text,
                        address: _addressController.text,
                        city: _cityController.text,
                        country: _countryController.text,
                        contact: _contactController.text,
                        buildingDetails: _buildingDetailsController.text,
                        products:
                            productsData, // Add your list of products here
                        total: '$total', // Set the initial subtotal
                      );

                      // Dispatch the PlaceOrderEvent with checkoutData
                      BlocProvider.of<CheckoutBloc>(context)
                          .add(PlaceOrderEvent(checkoutData));
                      BlocProvider.of<CartBloc>(context).add(ClearCart());
                    }
                  },
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.width * 0.1,
                      color: Colors.black,
                      child: Center(
                        child: Text(
                          'Make Order',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                                SizedBox(height: 10.0),

              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _countryController.dispose();
    _buildingDetailsController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  Widget TextFormFieldd(BuildContext context, TextEditingController controller,
      String? Function(String?)? validator) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
      child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.horizontal(),
              borderSide: BorderSide(
                  color: Colors.grey
                      .withOpacity(0.7)), // Border color when not focused
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.horizontal(),
              borderSide: BorderSide(
                  color: Colors.black
                      .withOpacity(0.5)), // Border color when focused
            ),
          ),
          validator: validator),
    );
  }
}

class BillingDetails extends StatelessWidget {
  const BillingDetails({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
      child: Text(
        title,
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
    );
  }
}
