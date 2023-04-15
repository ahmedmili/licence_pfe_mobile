import 'package:flutter/material.dart';
import 'package:saverapp/Screens/partner/partner_boxes.dart';

import 'boxform.dart';
import 'home_.dart';
import 'me_partner.dart';

class NavBottomScreen extends StatefulWidget {
  const NavBottomScreen({Key? key}) : super(key: key);

  @override
  State<NavBottomScreen> createState() => _NavBottomScreenState();
}

class _NavBottomScreenState extends State<NavBottomScreen> {
  int currentTabIndex = 0;
  late List<Widget> pages;
  late Widget currentPage;
  late HomeScreen partnerHome;
  late BoxFormScreen boxformScreen;
  late PartnerBoxes partnerboxesScreen;
  late MePartner mepartnerScreen;
  @override
  void initState() {
    super.initState();
    partnerHome = const HomeScreen();
    boxformScreen = BoxFormScreen();
    partnerboxesScreen = const PartnerBoxes();
    mepartnerScreen = const MePartner();
    pages = [partnerHome, boxformScreen, partnerboxesScreen, mepartnerScreen];
    currentPage = partnerHome;
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
