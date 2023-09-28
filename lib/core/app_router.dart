import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:store/models/category_model.dart';
import 'package:store/models/product_model.dart';
import 'package:store/screens/Cart/cart_screen.dart';
import 'package:store/screens/DetailsScreen/details_screen.dart';
import 'package:store/screens/FavoriteScreen/favorite_screen.dart';
import 'package:store/screens/HomeScreen/home_screen.dart';

import 'package:store/screens/SearchScreen/search_screen.dart';
import 'package:store/screens/checkout/checkout_screen.dart';
import 'package:store/screens/profileScreen/profile_screen.dart';

class AppRouter{

 static Route onGenerateRoute(RouteSettings settings){

  switch(settings.name){
    case '/':
    return HomeScreen.route();
     case CartScreen.routeName:
    return CartScreen.route();
    case ProfileScreen.routeName:
    return ProfileScreen.route();
    case SearchScreen.routeName:
    return SearchScreen.route(category: settings.arguments as Category);
    case DetailsScreen.routeName:
    return DetailsScreen.route(product: settings.arguments as Product);
    case FavoriteScreen.routeName:
    return FavoriteScreen.route();
   case Checkout.routeName:
    return Checkout.route();
   
    default: 
    return errorRoute();
  }

 }
 static Route errorRoute() {
    return MaterialPageRoute(
        settings: RouteSettings(name: '/error'),
        builder: (context) {
          return Scaffold(
            body: Center(child: Text('error')),
          );
        });
  }
}