// ignore_for_file: file_names

import 'package:flutter/material.dart';

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
          height: 70,
          width: 450,
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
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
                      Icon(
                        Icons.location_on,
                        color: Colors.green[800],
                      ),
                      const SizedBox(
                        width: 5,
                      ),
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
                      const SizedBox(
                        width: 15,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Text(
                      "Less than 6 Km",
                      style: TextStyle(
                          //fontWeight: FontWeight.bold,
                          color: Colors.green[800],
                          fontSize: 14),
                    ),
                  ),
                  //Text(widget.adress),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
