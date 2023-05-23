import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:saverapp/Models/partner.dart';
import 'package:saverapp/dimensions.dart';
import '../../Models/boxs.dart';
import '../../Models/order.dart';
import '../../widget/partnerDetails.dart';
import '../../Services/users.dart';

class OrderScreen extends StatefulWidget {
  // final Box box;
  final Partner partner;
  final Order? neworder;
  const OrderScreen({
    super.key,
    required this.partner,
    required this.neworder,
  });
  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  var qrstr = "let's Scan it";

  @override
  Widget build(BuildContext context) {
    print(widget.neworder!.box_category);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: Dimensions.width70),
              child: const Text(
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
        padding: const EdgeInsets.only(top: 2, left: 10, right: 10),
        child: Stack(
          children: <Widget>[
            Container(
              height: Dimensions.height60 * 11,
              width: Dimensions.width40 * 12,
              padding: EdgeInsets.only(
                  left: 15.0, right: 15.0, top: Dimensions.height30),
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
                                widget.neworder!.box_name,
                                style: const TextStyle(
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
                            widget.neworder!.box_category,
                            style: const TextStyle(
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
                          SizedBox(width: Dimensions.width10 / 2),
                          Text(
                            widget.neworder!.box_description,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      ),
                      SizedBox(height: Dimensions.height10),
                      Row(
                        children: [
                          Icon(
                            Icons.access_alarm,
                            color: Colors.green[800],
                          ),
                          SizedBox(width: Dimensions.width10 / 2),
                          Text(
                            "${widget.neworder!.box_startdate} -> ${widget.neworder!.box_enddate}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Dimensions.font28 / 2),
                          ),
                        ],
                      ),
                      SizedBox(height: Dimensions.height10),
                      Row(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Box Price :",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Dimensions.font28 / 2,
                                ),
                              ),
                              Text(
                                "${widget.neworder!.newprice}Dt",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.green[800]),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Quantity :",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Dimensions.font28 / 2,
                                ),
                              ),
                              Text(
                                "${widget.neworder!.quantity}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Dimensions.font28 / 2,
                                    color: Colors.green[800]),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Total :",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Dimensions.font28 / 2,
                                ),
                              ),
                              Text(
                                "${widget.neworder!.price}Dt",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.green[800]),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: Dimensions.height10),
                      Padding(
                        padding: EdgeInsets.only(right: Dimensions.width15),
                        child: const Divider(
                          color: Colors.grey,
                          thickness: 1,
                        ),
                      ),
                      SizedBox(height: Dimensions.height10 / 2),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(height: Dimensions.height20),
                                  Icon(
                                    Icons.person,
                                    color: Colors.green[800],
                                  ),
                                  SizedBox(width: Dimensions.width10 / 2),
                                  Text(
                                    widget.neworder!.partner_name,
                                    style: TextStyle(
                                        fontSize: Dimensions.font16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(height: Dimensions.height20),
                                  Icon(
                                    Icons.email,
                                    color: Colors.green[800],
                                  ),
                                  SizedBox(width: Dimensions.width10 / 2),
                                  Text(
                                    widget.partner.email,
                                    style: TextStyle(
                                        fontSize: Dimensions.font16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: Dimensions.width10),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const PartnerDetails()),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Show \nmore",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.green[800],
                                                fontSize: 12),
                                          ),
                                          Icon(
                                            Icons.arrow_forward,
                                            color: Colors.green[800],
                                            size: 35,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: Dimensions.height10),
                              Row(
                                children: [
                                  SizedBox(height: Dimensions.height20),
                                  Icon(
                                    Icons.phone,
                                    color: Colors.green[800],
                                  ),
                                  SizedBox(width: Dimensions.width10 / 2),
                                  Text(
                                    "${widget.partner.phone}",
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: Dimensions.height10),
                      Padding(
                        padding: EdgeInsets.only(right: Dimensions.width15),
                        child: const Divider(
                          color: Colors.grey,
                          thickness: 1,
                        ),
                      ),
                      SizedBox(height: Dimensions.height10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.camera_alt,
                                color: Colors.green[800],
                              ),
                              const SizedBox(width: 2),
                              const Text(
                                'Open your camera and scan the QrCode.',
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: Dimensions.width50 * 2,
                                top: Dimensions.height50),
                            child: ElevatedButton(
                              onPressed: scanQr,
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green[800],
                              ),
                              child: const Text(
                                ('SCANNER QRCODE'),
                              ),
                            ),
                          ),
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

  Future<void> scanQr() async {
    try {
      FlutterBarcodeScanner.scanBarcode('#2A99CF', 'cancel', true, ScanMode.QR)
          .then((value) {
        setState(() {
          qrstr = value;
        });
        // print("jsonData ==  $value");
        Map<String, dynamic> jsonDta = jsonDecode(value);
        UserService.verifAndTakeOrder(jsonDta);
      });
    } catch (e) {
      setState(() {
        qrstr = 'unable to read this';
      });
    }
  }
}
