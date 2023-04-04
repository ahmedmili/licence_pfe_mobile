import 'package:flutter/material.dart';
import 'package:saverapp/Screens/partner/box_screen.dart';
import 'package:saverapp/widget/searchField.dart';
import '../login_screen.dart';
import './profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Services/auth_service.dart';
import '../partner/boxform_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String token;
  late String role;

  static Future<void> doLogout(String token) async {
    try {
      await AuthServices.logout(token);
      // Do something on success
    } catch (e) {
      // Handle error
    }
  }

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
      body: ListView(
        padding: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
        children: <Widget>[
          SearchField(),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Votre texte ici",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              )
            ],
          ),
          Container(
            child: BoxScreen(),
          )
        ],
      ),
    );
  }
}
