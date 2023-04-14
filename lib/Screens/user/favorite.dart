import 'package:flutter/material.dart';
import 'package:saverapp/Models/boxs.dart';
import 'package:saverapp/Services/users.dart';
import 'package:saverapp/widget/box_list_view.dart';

import 'package:shared_preferences/shared_preferences.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  Future<String> readToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? "0";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Column(
            children: [
              FutureBuilder<String>(
                future: readToken(),
                builder: (context, tokenSnapshot) {
                  if (tokenSnapshot.hasData) {
                    return FutureBuilder<List<Box>>(
                      future: UserService.favorsBoxs(tokenSnapshot.data!),
                      builder: (context, snapshot) {
                        // print(snapshot.data);
                        if (snapshot.hasData) {
                          return SizedBox(
                            height: 800, // or any other fixed height

                            child: BoxScreen(
                              items: snapshot.data!,
                              directions: "V",
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.green[800]!),
                              strokeWidth: 5,
                            ),
                          );
                        }
                      },
                    );
                  } else if (tokenSnapshot.hasError) {
                    return Text('Error: ${tokenSnapshot.error}');
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.green[800]!),
                        strokeWidth: 5,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
