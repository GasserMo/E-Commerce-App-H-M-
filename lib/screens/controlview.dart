

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:store/models/category_model.dart';
import 'package:store/screens/Cart/cart_screen.dart';
import 'package:store/screens/FavoriteScreen/favorite_screen.dart';
import 'package:store/screens/HomeScreen/home_screen.dart';
import 'package:store/screens/SearchScreen/search.dart';
import 'package:store/screens/SearchScreen/search_screen.dart';
import 'package:store/screens/profileScreen/profile_screen.dart';

class ControlView extends StatefulWidget {
   ControlView({Key? key}) : super(key: key);

  @override
  State<ControlView> createState() => _ControlViewState();
}

class _ControlViewState extends State<ControlView> {
 int _selectedIndex = 0;

  final List<Widget> _pages = [HomeScreen(), SearchScreen(
    category: Category.categories[0],
  ),CartScreen(),FavoriteScreen(),
  ProfileScreen(),];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(FluentIcons.home_24_regular),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(FluentIcons.search_24_regular),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(FluentIcons.shopping_bag_24_regular),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(FluentIcons.heart_24_regular),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(FluentIcons.person_24_regular),
            label: '',
          ),
        ],
      ),
    );
  }


}