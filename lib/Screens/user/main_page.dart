import 'package:flutter/material.dart';
import 'package:saverapp/Screens/user/home.dart';
import 'package:saverapp/Screens/user/tour.dart';
import 'favorite.dart';
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
  late FavoriteScreen favoritecreen;
  late MeScreen meScreen;
  @override
  void initState() {
    super.initState();
    homeScreen = const HomeScreen();
    tourScreen = const TourScreen();
    favoritecreen = const FavoriteScreen();
    meScreen = const MeScreen();
    pages = [homeScreen, tourScreen, favoritecreen, meScreen];
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
        selectedItemColor: Colors.green[800],
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
            label: 'Me',
          ),
        ],
      ),
      body: currentPage,
    );
  }
}
