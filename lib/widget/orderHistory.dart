import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Models/order.dart';
import '../../Services/partners.dart';
import '../../widget/orderwidget_list.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({super.key});

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Order>>(
        future: PartnersService.getUserOrders("SUCCESS"),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return OrderwidgetScreenPartner(
              items: snapshot.data!,
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green[800]!),
                strokeWidth: 5,
              ),
            );
          }
        });
  }
}
