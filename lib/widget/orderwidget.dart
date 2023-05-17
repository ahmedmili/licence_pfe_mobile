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
        height: Dimensions.height50 * 2,
        width: Dimensions.width50 * 9,
        child: Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(Dimensions.radius20),
          child: Row(
            children: [
              Container(
                width: 70,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.green.shade800,
                    width: 2.0,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15),
                  Text(
                    "Quantity : ${widget.order.quantity}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "Price : ${widget.order.price}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "Collection begins : ${widget.order.box_startdate}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 5),
              const Icon(
                Icons.chevron_right,
              )
            ],
          ),
        ),
      ),
    );
  }
}
