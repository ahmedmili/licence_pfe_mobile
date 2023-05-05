// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:saverapp/Models/partner.dart';
import 'package:saverapp/Services/globals.dart';
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

  @override
  Widget build(BuildContext context) {
    GlobalController controller = Get.find();

    return ListView.builder(
      scrollDirection:
          widget.directions == "H" ? Axis.horizontal : Axis.vertical,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final box = items[index];
        return GestureDetector(
          onTap: () async {
            // Partner partner = globalController.partner;
            Partner partner = await UserService.getBoxPartnerInfo(box.id);

            controller.partner = partner;

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
