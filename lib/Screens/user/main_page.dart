import 'package:flutter/material.dart';
import 'package:saverapp/Screens/user/home.dart';
import 'package:saverapp/Screens/user/tour.dart';
import 'favorite.dart';
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
  late MeScreen meScreen;
  @override
  void initState() {
    super.initState();
    homeScreen = const HomeScreen();
    tourScreen = const TourScreen();
    favoritecreen = const FavoriteGlobal();
    meScreen = const MeScreen();
    pages = [homeScreen, tourScreen, favoritecreen, meScreen];
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
      body: Stack(
        children: [
          currentPage,
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 60,
              color: Colors.green[800],
              child: Center(
                child: Text("test"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
