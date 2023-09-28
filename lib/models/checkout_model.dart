import 'package:equatable/equatable.dart';
import 'package:store/models/product_model.dart';

class CheckoutModel extends Equatable {
  final String? fullName;
  final String? address;
  final String? city;
  final String? country;
  final String? buildingDetails;
  final List<Map<String, dynamic>>? products; // Accept a list of maps
  final String? total;
   final String? contact;
  const CheckoutModel( 
      {required this.fullName,
      required this.address,
      required this.city,
      required this.country,
      required this.buildingDetails,
      required this.products,
     required this.contact,
      required this.total});

  @override
  // TODO: implement props
  List<Object?> get props =>
      [fullName, address,  city, country,
      contact, buildingDetails, products, total];

  Map<String, Object> toDoucment() {
    Map customerAddress = Map();

    customerAddress['address'] = address;
    customerAddress['city'] = city;
    customerAddress['country'] = country;
    customerAddress['buildingDetails'] = buildingDetails;
    return {
      'customerAddress': customerAddress,
      'customerName': fullName!,
      'contact':contact!,
      'product': products!,
      'subtotal': total!,
      
    };
  }
}
