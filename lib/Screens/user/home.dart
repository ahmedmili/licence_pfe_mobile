import 'package:flutter/material.dart';
import 'package:saverapp/Models/boxs.dart';
import 'package:saverapp/widget/box_list_view.dart';
import 'package:saverapp/widget/searchField.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../../Services/users.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Column(
            children: [
              FutureBuilder<String>(
                future: readToken(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return FutureBuilder<List<Box>>(
                      future: UserService.getAvailableBoxs(snapshot.data!),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            children: [
                              const SizedBox(height: 40.0),
                              const SearchField(),
                              const SizedBox(height: 30.0),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 15.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    const Text(
                                      "All boxes available",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "View all",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green[800]),
                                        ),
                                        Icon(
                                          Icons.arrow_forward,
                                          color: Colors.green[800],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 15.0),
                              SizedBox(
                                height: 200, // or any other fixed height
                                child: BoxScreen(items: snapshot.data!),
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 15.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    const Text(
                                      "Recommended for you",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "View all",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green[800]),
                                        ),
                                        Icon(
                                          Icons.arrow_forward,
                                          color: Colors.green[800],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 15.0),
                              SizedBox(
                                height: 200, // or any other fixed height
                                child: BoxScreen(items: snapshot.data!),
                              ),
                            ],
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
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
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
