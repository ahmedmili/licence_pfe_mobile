import 'package:flutter/material.dart';
import 'package:saverapp/Screens/partner/foodDetails_partner.dart';
import 'package:saverapp/widget/boxCardPartner.dart';
import '../Models/boxs.dart';

class BoxScreenPartner extends StatefulWidget {
  const BoxScreenPartner(
      {super.key, required this.items, this.directions = "V"});
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FoodDetailsPartner(
                  box: box,
                ),
              ),
            );
          },
          child: widget.directions == "V"
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: 10),
                    BoxCardPartner(box: box),
                    const SizedBox(width: 10)
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: 10),
                    BoxCardPartner(box: box),
                    const SizedBox(height: 10)
                  ],
                ),
        );
      },
    );
  }
}
