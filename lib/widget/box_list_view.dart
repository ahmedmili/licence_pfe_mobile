import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/boxs.dart';
import 'boxCard.dart';

class BoxScreen extends StatefulWidget {
  const BoxScreen({super.key, required this.items});
  final List<Box> items;

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
      scrollDirection: Axis.horizontal,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final box = items[index];
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 10,
            ),
            Container(
              child: BoxCard(
                image: box.image,
                title: box.title,
                description: box.description,
                newPrice: box.newprice,
                oldPrice: box.oldprice,
              ),
            ),
            const SizedBox(width: 10),
          ],
        );
      },
    );
  }
}
