import 'package:flutter/material.dart';
import 'package:saverapp/Models/order.dart';
import 'package:saverapp/Services/globals.dart';
import 'package:saverapp/dimensions.dart';

class OrderwidgetPartner extends StatefulWidget {
  OrderwidgetPartner({
    super.key,
    required this.order,
  });

  Order order;

  @override
  State<OrderwidgetPartner> createState() => _OrderwidgetPartnerState();
}

class _OrderwidgetPartnerState extends State<OrderwidgetPartner> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 380,
      color: Colors.green[800],
      child: Center(
        child: Row(
          children: [
            Container(
              //width: Dimensions.width70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.black,
                  width: Dimensions.width10 / 5,
                ),
              ),
              child: CircleAvatar(
                radius: Dimensions.radius20,
                backgroundImage: NetworkImage(
                  "http://$localhost:8000/storage/boxs_imgs/${widget.order.box_image}",
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(height: Dimensions.height10 / 2),
                const Text(
                  "Your Order",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                SizedBox(height: Dimensions.height10 / 2),
                Text(
                  "The collection begins : ${widget.order.box_startdate}",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: Dimensions.font28 / 2),
                ),
              ],
            ),
            SizedBox(width: Dimensions.width10),
            const Icon(
              Icons.chevron_right,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
