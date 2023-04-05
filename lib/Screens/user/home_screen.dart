import 'package:flutter/material.dart';
import 'package:saverapp/Models/boxs.dart';
import 'package:saverapp/widget/box_screen.dart';
import 'package:saverapp/widget/searchField.dart';
import 'package:saverapp/widget/titleBox.dart';
// import '../login_screen.dart';
// import './profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Services/auth_service.dart';
// import '../partner/boxform_screen.dart';
import '../../Services/users_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // late String token;
  // late String role;

  static Future<void> doLogout(String token) async {
    try {
      await AuthServices.logout(token);
      // Do something on success
    } catch (e) {
      // Handle error
    }
  }

  // Future<void> readToken() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     token = prefs.getString('token') ?? "0";
  //     role = prefs.getString('role') ?? "user";
  //   });
  // }

  Future<String> readToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? "0";
  }

  @override
  void initState() {
    super.initState();
    readToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<String>(
      future: readToken(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return FutureBuilder<List<Box>>(
            future: PartnersService.getBoxs(snapshot.data!),
            builder: (context, snapshot) {
              // print(snapshot.data);
              if (snapshot.hasData) {
                return Column(
                  children: [
                    const SizedBox(height: 40.0),
                    const SearchField(),
                    const SizedBox(height: 30.0),
                    const TitleBox(),
                    const SizedBox(height: 15.0),
                    Expanded(
                      child: BoxScreen(items: snapshot.data!),
                    )
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return const CircularProgressIndicator();
              }
            },
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return const CircularProgressIndicator();
        }
      },
    ));
  }
}
