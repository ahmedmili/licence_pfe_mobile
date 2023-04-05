import 'package:flutter/material.dart';
import 'package:saverapp/widget/foodCategory.dart';

class TourScreen extends StatefulWidget {
  const TourScreen({super.key});

  @override
  State<TourScreen> createState() => _TourScreenState();
}

class _TourScreenState extends State<TourScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 40.0),
      child: const FoodCategory(),
    );
  }
}
