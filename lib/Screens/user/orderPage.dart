import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../Models/order.dart';
import '../../Services/partners.dart';
import '../../widget/orderwidget_list.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Order>>(
        future: PartnersService.getUserOrders("PENDING"),
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
                  Container(
                    height: 200,
                    width: 200,
                    child: Image(
                      image: AssetImage("assets/images/order.png"),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Time to order !",
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
