import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Waiting extends StatelessWidget {
  const Waiting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text(
        "We will contact you soon for more information .",
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.green.shade800,
            fontSize: 17),
      )),
    );
  }
}
