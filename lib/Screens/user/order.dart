import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saverapp/Models/partner.dart';
import 'package:saverapp/Screens/user/passorder.dart';

import '../../Models/boxs.dart';
import '../../widget/partnerDetails.dart';

class OrderScreen extends StatefulWidget {
  final Box box;
  final Partner partner;
  const OrderScreen({super.key, required this.box, required this.partner});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 70),
              child: Text(
                "Your Order",
                style: TextStyle(color: Colors.white),
              ),
            ),
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.close))
          ],
        ),
        backgroundColor: Colors.green[800],
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.grey,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 2),
        child: Stack(
          children: <Widget>[
            Container(
              height: 550,
              width: 480,
              padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 30),
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(20.0),
                child: Padding(
                  padding: const EdgeInsets.only(left: 17),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                CupertinoIcons.cube_box,
                                color: Colors.green[800],
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                widget.box.title,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(
                            Icons.store,
                            color: Colors.green[800],
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            widget.box.category,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(
                            Icons.description_outlined,
                            color: Colors.green[800],
                          ),
                          const SizedBox(width: 5),
                          Text(
                            widget.box.description,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(
                            Icons.access_alarm,
                            color: Colors.green[800],
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "${widget.box.startdate} -> ${widget.box.enddate}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Box Price :",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                "${widget.box.newprice} Dt",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.green[800]),
                              ),
                            ],
                          ),
                          const SizedBox(width: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Quantity :",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                "${widget.box.quantity} ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.green[800]),
                              ),
                            ],
                          ),
                          const SizedBox(width: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Total :",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                "${widget.box.newprice} Dt",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.green[800]),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Padding(
                        padding: EdgeInsets.only(right: 15.0),
                        child: Divider(
                          color: Colors.grey,
                          thickness: 1,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const SizedBox(height: 20),
                                  Icon(
                                    Icons.person,
                                    color: Colors.green[800],
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    widget.partner.name,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const SizedBox(height: 20),
                                  Icon(
                                    Icons.email,
                                    color: Colors.green[800],
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    widget.partner.email,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 85),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const PartnerDetails()),
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          "Show more",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green[800],
                                              fontSize: 14),
                                        ),
                                        Icon(
                                          Icons.arrow_forward,
                                          color: Colors.green[800],
                                          size: 40,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const SizedBox(height: 20),
                                  Icon(
                                    Icons.phone,
                                    color: Colors.green[800],
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    "${widget.partner.phone}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Padding(
                        padding: EdgeInsets.only(right: 15.0),
                        child: Divider(
                          color: Colors.grey,
                          thickness: 1,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.camera_alt,
                                color: Colors.green[800],
                              ),
                              SizedBox(width: 2),
                              Text(
                                'Open your camera and scan the QrCode.',
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.only(left: 130, top: 30),
                              child: Icon(
                                Icons.camera_alt,
                                size: 100,
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
