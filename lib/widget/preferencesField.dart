import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:saverapp/Screens/user/tour.dart';

import '../Screens/user/congratulations.dart';

class PreferencesField extends StatelessWidget {
  const PreferencesField({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 180,
          width: 450,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(
              color: Colors.green,
              width: 2.0,
            ),
          ),
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(20.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 17),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Text(
                        "filter your box according to your preferences",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.green[800]),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Text(
                      "We can recommend the most suitable surprise boxes based on your filtering criteria.",
                      style: TextStyle(
                          //fontWeight: FontWeight.bold,
                          color: Colors.green[800],
                          fontSize: 14),
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 300,
                    padding: const EdgeInsets.only(
                        top: 30, bottom: 30, left: 40, right: 20),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TourScreen()),
                        );
                      },
                      color: Colors.green[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "CHANGE PREFERENCES",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
