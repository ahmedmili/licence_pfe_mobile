import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:google_nav_bar/google_nav_bar.dart';

// ignore: must_be_immutable
class MyBottonNavBarOrder extends StatelessWidget {
  void Function(int)? onTabChange;
  MyBottonNavBarOrder({
    super.key,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    return GNav(
      onTabChange: (value) => onTabChange!(value),
      mainAxisAlignment: MainAxisAlignment.center,
      activeColor: Colors.green[800],
      tabActiveBorder: Border.all(
        color: Colors.green.shade800,
      ),
      gap: 8,
      tabs: const [
        //Favorite Partner
        GButton(
          icon: Icons.list,
          text: 'Current Orders',
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 4),
        ),

        //Favorite Box
        GButton(
          icon: Icons.history,
          text: 'Order History',
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 4),
        ),
      ],
    );
  }
}
