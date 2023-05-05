import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saverapp/Screens/user/favorite_partner.dart';
import 'package:saverapp/Screens/user/filter.dart';
import 'package:saverapp/Services/geoLocator.dart';
import 'package:saverapp/widget/bottom_nav_bar.dart';
import 'package:saverapp/widget/google_map.dart';

import '../../widget/adresseField.dart';
import '../../widget/bottom_nav_bar_fav.dart';
import 'favorite.dart';

class FavoriteGlobal extends StatefulWidget {
  const FavoriteGlobal({super.key});

  @override
  State<FavoriteGlobal> createState() => _FavoriteGlobalState();
}

class _FavoriteGlobalState extends State<FavoriteGlobal> {
  GeoLocatorController geoController = Get.find<GeoLocatorController>();

  int _selectedIndex = 0;
  void navigateBottomBar(int newIndex) {
    setState(() {
      _selectedIndex = newIndex;
    });
  }

  //pages to display
  final List<Widget> _pages = [
    //favorite partner page
    const FavoritePartner(),
    //favorite boxes
    const FavoriteScreen(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 40),
          MyBottonNavBarFav(
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
