import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saverapp/Screens/user/filter.dart';
import 'package:saverapp/Services/geoLocator.dart';
import 'package:saverapp/widget/bottom_nav_bar.dart';
import 'package:saverapp/widget/google_map.dart';

import '../../widget/adresseField.dart';

class TourScreen extends StatefulWidget {
  const TourScreen({super.key});

  @override
  State<TourScreen> createState() => _TourScreenState();
}

class _TourScreenState extends State<TourScreen> {
  GeoLocatorController geoController = Get.find<GeoLocatorController>();

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
    // cart page
    const MapSample(),
    // const Congratulations(),
  ];

  @override
  void initState() {
    super.initState();
    // String adress = geoController.getAddressFromLatLng(37.4219983, -122.084);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 40),
          AdresseField(adress: geoController.adress.toString()),
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
