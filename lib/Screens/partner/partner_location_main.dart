import 'package:flutter/material.dart';
import 'package:saverapp/Screens/partner/partner_boxes.dart';

import '../../widget/google_map.dart';
import 'boxform.dart';

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
  late MapSample MapSceern;
  late BoxFormScreen boxformScreen;
  late PartnerBoxes partnerboxesScreen;
  late MePartner mepartnerScreen;
  @override
  void initState() {
    super.initState();
    MapSceern = const MapSample();
    boxformScreen = const BoxFormScreen();

    pages = [MapSceern, boxformScreen, partnerboxesScreen, mepartnerScreen];
    currentPage = MapSceern;
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
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'List',
          ),
        ],
      ),
      body: currentPage,
    );
  }
}
