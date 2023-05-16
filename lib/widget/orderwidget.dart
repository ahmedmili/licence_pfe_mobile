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
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        height: Dimensions.height45 * 2,
        width: Dimensions.width60 * 9,
        padding: EdgeInsets.only(
            left: Dimensions.width10, right: Dimensions.width10),
        child: Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(Dimensions.radius20),
          child: Padding(
            padding: const EdgeInsets.only(left: 17),
            child: Row(
              children: [
                Container(
                  width: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                      "http://$localhost:8000/storage/boxs_imgs/${widget.order.box_image}",
                    ),
                  ),
                ),
                Column(
                  children: [
                    const Text(
                      "Your Order",
                      style: TextStyle(
                          // color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    Text(
                      "${widget.order.box_startdate}",
                      style: TextStyle(
                          //  color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  ],
                ),
                const Icon(
                  Icons.chevron_right,
                  //color: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
