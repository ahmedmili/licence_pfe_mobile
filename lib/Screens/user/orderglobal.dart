import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saverapp/Screens/user/favorite_partner.dart';
import 'package:saverapp/Screens/user/orderPage.dart';
import 'package:saverapp/Services/geoLocator.dart';
import 'package:saverapp/widget/bottom_nav_bar_order.dart';
import 'package:saverapp/widget/orderHistory.dart';

import '../../widget/bottom_nav_bar_fav.dart';
import 'favorite.dart';

class OrderGlobal extends StatefulWidget {
  const OrderGlobal({super.key});

  @override
  State<OrderGlobal> createState() => _OrderGlobalState();
}

class _OrderGlobalState extends State<OrderGlobal> {
  GeoLocatorController geoController = Get.find<GeoLocatorController>();

  int _selectedIndex = 0;
  void navigateBottomBar(int newIndex) {
    setState(() {
      _selectedIndex = newIndex;
    });
  }

  //pages to display
  final List<Widget> _pages = [
    const OrderPage(),
    const OrderHistory(),
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
          MyBottonNavBarOrder(
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
