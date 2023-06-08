import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saverapp/Models/boxs.dart';
import 'package:saverapp/Services/geoLocator.dart';
import 'package:saverapp/widget/adresseField.dart';
import 'package:saverapp/widget/box_list_view.dart';
import '../../Services/users.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GeoLocatorController geoController = Get.find<GeoLocatorController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Column(
            children: [
              FutureBuilder<List<Box>>(
                future: UserService.getAvailableBoxs(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    // print(geoController.adress.value);
                    return Column(
                      children: [
                        const SizedBox(height: 20.0),
                        const AdresseField(
                            // adress: geoController.adress.value,
                            ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const <Widget>[
                              Text(
                                "Recommended for you",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        SizedBox(
                          height: 200,
                          child: BoxScreen(items: snapshot.data!),
                        ),
                        SizedBox(height: 20),
                        Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 5),
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 240.0),
                              child: const Text(
                                "Available",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(height: 15.0),
                            SizedBox(
                              width: 340,
                              height: 400,
                              child: BoxScreen(
                                items: snapshot.data!,
                                directions: "v",
                              ),
                            ),
                          ],
                        ),
                      ],
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
