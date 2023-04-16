import 'package:flutter/material.dart';
import 'boxform.dart';
import '../login.dart';
import 'profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Services/auth.dart';
import '../../widget/box_list_view.dart';

class HomePartnerScreen extends StatefulWidget {
  const HomePartnerScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePartnerScreenState createState() => _HomePartnerScreenState();
}

class _HomePartnerScreenState extends State<HomePartnerScreen> {
  late String token;
  late String role;

  // static Future<void> doLogout() async {
  //   try {
  //     await AuthServices.logout();
  //     // Do something on success
  //   } catch (e) {
  //     // Handle error
  //   }
  // }

  Future<void> readToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token') ?? "0";
      role = prefs.getString('role') ?? "user";
    });
  }

  @override
  void initState() {
    super.initState();
    readToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text('Partner home'),
        //   actions: [
        //     IconButton(
        //       icon: const Icon(Icons.exit_to_app),
        //       onPressed: () async {
        //         await readToken();
        //         await doLogout();
        //         Navigator.of(context).pushAndRemoveUntil(
        //             MaterialPageRoute(builder: (context) => const LoginScreen()),
        //             (route) => false);
        //       },
        //     )
        //   ],
        // ),
        // body: currentIndex == 0 ? BoxScreen() : ProfileScreen(),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     Navigator.of(context).push(MaterialPageRoute(
        //         builder: (context) => BoxFormScreen(
        //             //title: 'Add New Box',
        //             )));
        //   },
        //   child: Icon(Icons.add),
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // bottomNavigationBar: BottomAppBar(
        //   notchMargin: 5,
        //   elevation: 10,
        //   clipBehavior: Clip.antiAlias,
        //   shape: const CircularNotchedRectangle(),
        // child: BottomNavigationBar(
        //   items: const [
        //     BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
        //     BottomNavigationBarItem(icon: Icon(Icons.person), label: '')
        //   ],
        //   currentIndex: currentIndex,
        //   onTap: (val) {
        //     setState(() {
        //       currentIndex = val;
        //     });
        //   },
        // ),
        //   ),
        );
  }
}
