import 'package:flutter/material.dart';
import 'package:saverapp/Models/order.dart';
import 'package:saverapp/Screens/partner/foodDetails_partner.dart';
import 'package:saverapp/widget/boxCardPartner.dart';
import 'package:saverapp/widget/orderDetails.dart';
import '../Models/boxs.dart';
import 'orderCardPartner.dart';

class OrderScreenPartner extends StatefulWidget {
  const OrderScreenPartner({super.key, required this.items});
  final List<Order> items;

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
      itemCount: items.length,
      itemBuilder: (context, index) {
        final order = items[index];
        return GestureDetector(
          onTap: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OrderDetailsScreen(),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              OrderCardPartner(order: order),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}
