import 'package:flutter/material.dart';
import 'package:saverapp/Screens/user/home.dart';
import 'package:saverapp/Screens/user/tour.dart';

import '../partner/profile.dart';
import 'favorite.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentTabIndex = 0;
  late List<Widget> pages;
  late Widget currentPage;
  late HomeScreen homeScreen;
  late TourScreen tourScreen;
  late FavoriteScreen favoritecreen;
  late ProfileScreen profileScreen;
  @override
  void initState() {
    super.initState();
    homeScreen = HomeScreen();
    tourScreen = TourScreen();
    favoritecreen = FavoriteScreen();
    profileScreen = ProfileScreen();
    pages = [homeScreen, tourScreen, favoritecreen, profileScreen];
    currentPage = homeScreen;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          setState(() {
            currentTabIndex = index;
            currentPage = pages[index];
          });
        },
        currentIndex: currentTabIndex,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket),
            label: 'Tour',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      body: currentPage,
    );
  }
}
