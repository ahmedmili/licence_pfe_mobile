import 'package:flutter/material.dart';
import 'package:saverapp/Screens/user/congratulations.dart';
import 'package:saverapp/Screens/user/filter.dart';
import 'package:saverapp/widget/bottom_nav_bar.dart';

import '../../widget/adresseField.dart';

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
    const Congratulations(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 40),
          const AdresseField(),
          const SizedBox(height: 10),
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
