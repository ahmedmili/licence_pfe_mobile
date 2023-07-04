// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:saverapp/Models/order.dart';
import 'package:saverapp/Services/globals.dart';
import 'package:saverapp/dimensions.dart';

// ignore: must_be_immutable
class OrderCardPartner extends StatefulWidget {
  OrderCardPartner({
    super.key,
    required this.order,
  });

  Order order;

  @override
  State<OrderCardPartner> createState() => _OrderCardPartnerState();
}

class _OrderCardPartnerState extends State<OrderCardPartner> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        height: 130,
        width: 400,
        child: Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(Dimensions.radius20),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    child: Container(
                      width: 70,
                      height: 70,
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
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Icon(Icons.person_2_outlined,
                              color: Colors.green.shade800),
                          Text(
                            widget.order.user_name,
                            style: const TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.phone, color: Colors.green.shade800),
                          Text(
                            "${widget.order.user_phone}",
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Icon(Icons.production_quantity_limits,
                              color: Colors.green.shade800),
                          Text(
                            "${widget.order.quantity}",
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.money, color: Colors.green.shade800),
                          Text(
                            "${widget.order.price}",
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(width: 30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15),
                      Row(
                        children: const [
                          Icon(
                            Icons.chevron_right,
                            size: 40,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: Dimensions.height10),
              Row(
                children: [
                  const SizedBox(width: 15),
                  Icon(
                    Icons.access_alarm,
                    color: Colors.green[800],
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "${widget.order.box_startdate} -> ${widget.order.box_enddate}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
