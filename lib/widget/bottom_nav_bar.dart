import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:google_nav_bar/google_nav_bar.dart';

// ignore: must_be_immutable
class MyBottonNavBar extends StatelessWidget {
  void Function(int)? onTabChange;
  MyBottonNavBar({
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
        //List
        GButton(
          icon: Icons.list,
          text: 'List',
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        ),
        //cart
        GButton(
          icon: CupertinoIcons.map,
          text: 'Cart',
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        ),
      ],
    );
  }
}
