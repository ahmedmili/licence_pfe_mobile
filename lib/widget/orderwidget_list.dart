import 'package:flutter/material.dart';
import 'package:saverapp/Models/order.dart';
import 'package:saverapp/widget/orderDetails.dart';
import 'orderCardPartner.dart';
import 'orderWidget.dart';

class OrderwidgetScreenPartner extends StatefulWidget {
  const OrderwidgetScreenPartner({super.key, required this.items});
  final List<Order> items;

  @override
  State<OrderwidgetScreenPartner> createState() =>
      _OrderwidgetScreenPartnerState();
}

class _OrderwidgetScreenPartnerState extends State<OrderwidgetScreenPartner> {
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
                builder: (context) => OrderDetailsScreen(
                  order: order,
                ),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OrderwidgetPartner(order: order),
            ],
          ),
        );
      },
    );
  }
}
