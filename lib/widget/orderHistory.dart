// ignore_for_file: file_names

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
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green[800]!),
                strokeWidth: 5,
              ),
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return OrderwidgetScreenPartner(
              items: snapshot.data!,
            );
          } else {
            return Center(
              child: Column(
                children: [
                  const SizedBox(height: 190),
                  const SizedBox(
                    height: 200,
                    width: 200,
                    child: Image(
                      image: AssetImage("assets/images/order.png"),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Time to order and enjoy!",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.orange.shade900,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            );
          }
        });
  }
}
