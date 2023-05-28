import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saverapp/Screens/partner/partner_boxes.dart';

import 'boxform.dart';

import 'home_partner.dart';
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
  late HomePartnerScreen partnerHome;
  late BoxFormScreen boxformScreen;
  late PartnerBoxes partnerboxesScreen;
  late MePartner mepartnerScreen;
  @override
  void initState() {
    super.initState();
    partnerHome = const HomePartnerScreen();
    boxformScreen = const BoxFormScreen();
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
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: ('home'.tr).toUpperCase(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.add),
            label: ('add_box'.tr).toUpperCase(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              CupertinoIcons.cube_box,
            ),
            label: ('Your_Boxes'.tr).toUpperCase(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_3_outlined),
            label: ('Me'.tr).toUpperCase(),
          ),
        ],
      ),
      body: currentPage,
    );
  }
}
