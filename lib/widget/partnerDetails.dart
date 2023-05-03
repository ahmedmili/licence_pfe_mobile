// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:saverapp/Models/partner.dart';
import 'package:saverapp/widget/neonButtonPartner.dart';

import 'neonButton.dart';

class PartnerDetails extends StatefulWidget {
  const PartnerDetails({super.key});

  @override
  State<PartnerDetails> createState() => _PartnerDetailsState();
}

class _PartnerDetailsState extends State<PartnerDetails> {
  @override
  Widget build(BuildContext context) {
    final Partner partner = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.grey,
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: 500,
            width: 400,
            padding: const EdgeInsets.only(left: 35.0, right: 25.0, top: 0),
            child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 60,
                            width: 100,
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
                                "http://10.0.2.2:8000/storage/partner_imgs/${partner.image}",
                                headers: {
                                  "Keep-Alive": "timeout=20",
                                },
                              ),
                            ),
                          ),
                          Text(
                            "${partner.name}",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      //like
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 10, bottom: 20),
                        child: const NeuButtonPartner(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      const SizedBox(width: 20),
                      Icon(
                        Icons.store,
                        color: Colors.green[800],
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "Category : ${partner.category}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          //color: Colors.green[800]
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const SizedBox(width: 20),
                      Icon(
                        Icons.description_outlined,
                        color: Colors.green[800],
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "Description : ${partner.description}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const SizedBox(width: 20),
                      Icon(
                        Icons.phone_outlined,
                        color: Colors.green[800],
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "Phone : ${partner.phone}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const SizedBox(width: 20),
                      Icon(
                        Icons.email_outlined,
                        color: Colors.green[800],
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "Email : ${partner.email}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const SizedBox(width: 20),
                      Icon(
                        Icons.access_alarm_outlined,
                        color: Colors.green[800],
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "Opening Time : ${partner.openingtime}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const SizedBox(width: 20),
                      Icon(
                        Icons.access_time_filled,
                        color: Colors.green[800],
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "Closing Time : ${partner.closingtime}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const SizedBox(width: 20),
                      Icon(
                        Icons.location_on_outlined,
                        color: Colors.green[800],
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "Address :",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
