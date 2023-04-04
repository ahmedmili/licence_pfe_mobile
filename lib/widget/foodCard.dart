import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class FoodCard extends StatelessWidget {
  const FoodCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: <Widget>[
          Image(
            image: AssetImage("assets/images/fruitsandvegetables.png"),
            height: 65.0,
            width: 65.0,
          ),
          Text("Fruits and Vegetables")
        ],
      ),
    );
  }
}
