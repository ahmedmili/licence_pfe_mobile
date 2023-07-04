import 'package:flutter/material.dart';
import 'package:saverapp/Screens/user/home.dart';
import 'package:saverapp/Screens/user/orderglobal.dart';
import 'package:saverapp/Screens/user/tour.dart';
import 'favoriteglobal.dart';
import 'me.dart';

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
  late FavoriteGlobal favoritecreen;
  late OrderGlobal orderScreen;
  late MeScreen meScreen;
  @override
  void initState() {
    super.initState();
    homeScreen = const HomeScreen();
    tourScreen = const TourScreen();
    favoritecreen = const FavoriteGlobal();
    orderScreen = const OrderGlobal();
    meScreen = const MeScreen();
    pages = [homeScreen, tourScreen, favoritecreen, orderScreen, meScreen];
    currentPage = homeScreen;
  }

  void navigateToTourScreen() {
    setState(() {
      currentTabIndex = 1; // Index de l'écran "TourScreen"
      currentPage = pages[currentTabIndex];
    });
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
        selectedItemColor: Colors.green[800],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Preferences',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            label: 'Me',
          ),
        ],
      ),
      body: Stack(
        children: [
          currentPage,
        ],
      ),
    );
  }
}
