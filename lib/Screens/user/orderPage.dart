import 'package:flutter/cupertino.dart';
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
        future: PartnersService.getUserOrders(),
        builder: (context, snapshot) {
          // print(snapshot.data);
          //print(snapshot.data![0].box_category);
          if (snapshot.hasData) {
            return OrderwidgetScreenPartner(
              items: snapshot.data!,
            );
          } else {
            return const Text("No data available");
          }
        });
  }
}
