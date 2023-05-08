import 'package:flutter/material.dart';
import 'package:saverapp/Models/order.dart';
import 'package:saverapp/Screens/partner/foodDetails_partner.dart';
import 'package:saverapp/widget/boxCardPartner.dart';
import '../Models/boxs.dart';
import 'orderCardPartner.dart';

class OrderScreenPartner extends StatefulWidget {
  const OrderScreenPartner(
      {super.key, required this.items, this.directions = "H"});
  final List<Order> items;
  final String directions;
  @override
  State<OrderScreenPartner> createState() => _OrderScreenPartnerState();
}

class _OrderScreenPartnerState extends State<OrderScreenPartner> {
  get items => widget.items;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection:
          widget.directions == "V" ? Axis.horizontal : Axis.vertical,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final order = items[index];
        return GestureDetector(
          onTap: () async {},
          child: widget.directions == "H"
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: 10),
                    OrderCardPartner(order: order),
                    const SizedBox(width: 10)
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    OrderCardPartner(order: order),
                    const SizedBox(height: 20),
                  ],
                ),
        );
      },
    );
  }
}
