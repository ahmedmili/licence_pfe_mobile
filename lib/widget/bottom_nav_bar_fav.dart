import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:google_nav_bar/google_nav_bar.dart';

// ignore: must_be_immutable
class MyBottonNavBarFav extends StatelessWidget {
  void Function(int)? onTabChange;
  MyBottonNavBarFav({
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
          text: 'Favorite Partners',
          padding: EdgeInsets.symmetric(horizontal: 75, vertical: 4),
        ),

        //cart
        GButton(
          icon: CupertinoIcons.map,
          text: 'Favorite Boxes',
          padding: EdgeInsets.symmetric(horizontal: 75, vertical: 4),
        ),
      ],
    );
  }
}
