import 'package:flutter/material.dart';
import 'package:saverapp/Models/partner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/boxs.dart';
import '../Services/users.dart';
import 'boxCard.dart';
import 'foodDetails.dart';

class BoxScreen extends StatefulWidget {
  const BoxScreen({super.key, required this.items, this.directions = "H"});
  final List<Box> items;
  final String directions;
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
        return GestureDetector(
          onTap: () async {
            String token = await readToken();
            Partner partner =
                await UserService.getBoxPartnerInfo(token, box.id);
            // ignore: use_build_context_synchronously
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FoodDetails(
                  box: box,
                  partner: partner,
                ),
              ),
            );
          },
          child: widget.directions == "H"
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: 10),
                    BoxCard(box: box),
                    const SizedBox(width: 10)
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BoxCard(
                      box: box,
                    ),
                    const SizedBox(height: 20)
                  ],
                ),
        );
      },
    );
  }
}
