import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/boxs.dart';
import 'boxCard.dart';

class BoxScreen extends StatefulWidget {
  BoxScreen({super.key, required this.items, this.directions = "H"});
  final List<Box> items;
  String directions;
  @override
  State<BoxScreen> createState() => _BoxScreenState();
}

class _BoxScreenState extends State<BoxScreen> {
  get items => widget.items;

  @override
  void initState() {
    super.initState();
  }

  Future<String> readToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? "0";
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection:
          widget.directions == "H" ? Axis.horizontal : Axis.vertical,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final box = items[index];
        return widget.directions == "H"
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 10),
                  BoxCard(
                    image: box.image,
                    title: box.title,
                    description: box.description,
                    newPrice: box.newprice,
                    oldPrice: box.oldprice,
                    remaining_quantity: box.remaining_quantity,
                  ),
                  const SizedBox(width: 10)
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BoxCard(
                    image: box.image,
                    title: box.title,
                    description: box.description,
                    newPrice: box.newprice,
                    oldPrice: box.oldprice,
                    remaining_quantity: box.remaining_quantity,
                  ),
                  const SizedBox(height: 20)
                ],
              );
      },
    );
  }
}
