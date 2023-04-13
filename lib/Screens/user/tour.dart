import 'package:flutter/material.dart';
import 'package:saverapp/Screens/user/cart.dart';
import 'package:saverapp/Screens/user/filter.dart';
import 'package:saverapp/widget/bottom_nav_bar.dart';
import 'package:saverapp/widget/foodCategory.dart';

class TourScreen extends StatefulWidget {
  const TourScreen({super.key});

  @override
  State<TourScreen> createState() => _TourScreenState();
}

class _TourScreenState extends State<TourScreen> {
  int _selectedIndex = 0;
  void navigateBottomBar(int newIndex) {
    setState(() {
      _selectedIndex = newIndex;
    });
  }

  //pages to display
  final List<Widget> _pages = [
    //filtre page
    const Filter(),
    //cart page
    const Cart(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 45,
          ),
          MyBottonNavBar(
            onTabChange: (index) => navigateBottomBar(index),
          ),
          Expanded(
            child: _pages[_selectedIndex],
          ),
        ],
      ),
    );
  }
}
