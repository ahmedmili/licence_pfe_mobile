// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:saverapp/dimensions.dart';

class AdresseField extends StatefulWidget {
  const AdresseField({super.key, required this.adress});

  final String adress;
  @override
  State<AdresseField> createState() => _AdresseFieldState();
}

class _AdresseFieldState extends State<AdresseField> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: Dimensions.height50 * 2,
          width: Dimensions.width50 * 9,
          padding: EdgeInsets.only(
              left: Dimensions.width10, right: Dimensions.width10),
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(Dimensions.radius20),
            child: Padding(
              padding: const EdgeInsets.only(left: 17),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: Dimensions.height15),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.green[800],
                      ),
                      SizedBox(width: Dimensions.height10 / 2),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Text(
                            widget.adress,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green[800],
                                fontSize: 16),
                          ),
                        ),
                      ),
                      SizedBox(width: Dimensions.width15),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: Dimensions.width30),
                    child: Text(
                      "Less than 6 Km",
                      style: TextStyle(
                          //fontWeight: FontWeight.bold,
                          color: Colors.green[800],
                          fontSize: Dimensions.font28 / 2),
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
