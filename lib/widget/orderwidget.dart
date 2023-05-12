import 'package:flutter/material.dart';
import 'package:saverapp/Models/order.dart';
import 'package:saverapp/Services/globals.dart';

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
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 60,
        color: Colors.green[800],
        child: Center(
          child: Row(
            children: [
              Container(
                width: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.black,
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
                children: [
                  const SizedBox(height: 5),
                  const Text(
                    "Your Order",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "The collection begins : ${widget.order.box_startdate}",
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(width: 15),
              const Icon(
                Icons.chevron_right,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
