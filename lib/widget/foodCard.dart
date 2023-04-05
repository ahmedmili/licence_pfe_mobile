import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class FoodCard extends StatelessWidget {
  final String categoryName;
  final String imagePath;
  const FoodCard(
      {super.key, required this.categoryName, required this.imagePath});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Row(
          children: <Widget>[
            Image(
              image: AssetImage(imagePath),
              height: 65.0,
              width: 65.0,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              categoryName,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            )
          ],
        ),
      ),
    );
  }
}
