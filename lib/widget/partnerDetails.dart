// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saverapp/Services/globals.dart';
import 'package:saverapp/widget/neonButtonPartner.dart';

class PartnerDetails extends StatefulWidget {
  const PartnerDetails({super.key});

  @override
  State<PartnerDetails> createState() => _PartnerDetailsState();
}

class _PartnerDetailsState extends State<PartnerDetails> {
  GlobalController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 50),
              child: Text(
                "Commerce Details",
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
        padding: const EdgeInsets.only(top: 30),
        child: Stack(
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
                                  "http://192.168.100.34:8000/storage/partner_imgs/${controller.partner.image}",
                                  headers: {
                                    "Keep-Alive": "timeout=20",
                                  },
                                ),
                              ),
                            ),
                            Text(
                              controller.partner.name,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        //like
                        const Padding(
                          padding: EdgeInsets.only(
                              left: 20, right: 20, top: 10, bottom: 20),
                          child: NeuButtonPartner(),
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
                          "Category : ${controller.partner.category}",
                          style: const TextStyle(
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
                          "Description : ${controller.partner.description}",
                          style: const TextStyle(
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
                          "Phone : ${controller.partner.phone}",
                          style: const TextStyle(
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
                          "Email : ${controller.partner.email}",
                          style: const TextStyle(
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
                          "Opening Time : ${controller.partner.openingtime}",
                          style: const TextStyle(
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
                          "Closing Time : ${controller.partner.closingtime}",
                          style: const TextStyle(
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
                        const Text(
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
      ),
    );
  }
}
