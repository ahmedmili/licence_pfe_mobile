import 'package:flutter/material.dart';
import 'package:saverapp/Models/partner.dart';
import '../Models/boxs.dart';
import '../Services/users.dart';
import 'boxCard.dart';
import 'foodDetails.dart';

class BoxScreenPartner extends StatefulWidget {
  const BoxScreenPartner(
      {super.key, required this.items, this.directions = "H"});
  final List<Box> items;
  final String directions;
  @override
  State<BoxScreenPartner> createState() => _BoxScreenPartnerState();
}

class _BoxScreenPartnerState extends State<BoxScreenPartner> {
  get items => widget.items;

  @override
  void initState() {
    super.initState();
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
            // Partner partner = await UserService.getBoxPartnerInfo(box.id);
            // ignore: use_build_context_synchronously
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => FoodDetails(
            //       box: box,
            //       partner: partner,
            //     ),
            //   ),
            // );
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
